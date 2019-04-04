Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AB120882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfDDIr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:41590 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfDDIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:57 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBy1V-00074w-MM; Thu, 04 Apr 2019 10:47:01 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBy1V-0005wb-CG; Thu, 04 Apr 2019 10:47:01 +0200
Subject: Re: [PATCH net-next] tcp: Ensure DCTCP reacts to losses
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190404082055.8981-1-olivier.tilmans@nokia-bell-labs.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <efdc9c07-1feb-d594-7954-e4e6a379a53d@iogearbox.net>
Date:   Thu, 4 Apr 2019 10:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190404082055.8981-1-olivier.tilmans@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 10:26 AM, Tilmans, Olivier (Nokia - BE/Antwerp) wrote:
> RFC8257 §3.5 explicitly states that DCTCP should "react to loss
> episode in the same way that a conventional TCP".
> This is also the behavior on MS Windows.
> 
> Currently, Linux DCTCP performs no ssthresh reduction when losses
> are encountered. Optionally, the dctcp_clamp_alpha_on_loss resets
> alpha to its maximal value if a RTO happens. This behavior
> is sub-optimal for at least two reasons: i) it ignores losses
> triggering fast retransmissions; and ii) it causes unnecessary large
> cwnd reduction in the future if the loss was isolated as it resets
> the historical term of DCTCP's alpha EWMA to its maximal value (i.e.,
> denoting a total congestion). The second reason has an especially
> noticeable effect when using DCTCP in high BDP environments, where
> alpha normally stays at low values.
> 
> This patch replace the clamping of alpha by setting ssthresh to
> half of cwnd for both fast retransmissions and RTOs, at most once
> per RTT. To reflect the change, the dctcp_clamp_alpha_on_loss option
> has been renamed to dctcp_halve_cwnd_on_loss.
> 
> The table below shows experimental results where we measured the
> drop probability of a PIE AQM (not applying ECN marks) at a
> bottleneck in the presence of a single TCP flow with either the
> alpha-clamping option enabled or the cwnd halving proposed by this
> patch. Results using reno or cubic are given for comparison.
> 
>                           |  Link   |   RTT    |    Drop
>                  TCP CC   |  speed  | base+AQM | probability
>         ==================|=========|==========|============
>                     CUBIC |  40Mbps |  7+20ms  |    0.21%
>                      RENO |         |          |    0.19%
>         DCTCP-CLAMP-ALPHA |         |          |   25.80%
>          DCTCP-HALVE-CWND |         |          |    0.22%
>         ------------------|---------|----------|------------
>                     CUBIC | 100Mbps |  7+20ms  |    0.03%
>                      RENO |         |          |    0.02%
>         DCTCP-CLAMP-ALPHA |         |          |   23.30%
>          DCTCP-HALVE-CWND |         |          |    0.04%
>         ------------------|---------|----------|------------
>                     CUBIC | 800Mbps |   1+1ms  |    0.04%
>                      RENO |         |          |    0.05%
>         DCTCP-CLAMP-ALPHA |         |          |   18.70%
>          DCTCP-HALVE-CWND |         |          |    0.06%
> 
> We see that, without halving its cwnd for all source of losses,
> DCTCP drives the AQM to large drop probabilities in order to keep
> the queue length under control (i.e., it repeatedly faces RTOs).
> Instead, if DCTCP reacts to all source of losses, it can then be
> controlled by the AQM using similar drop levels than cubic or reno.
> 
> Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> Cc: Bob Briscoe <research@bobbriscoe.net>
> Cc: Lawrence Brakmo <brakmo@fb.com>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: Daniel Borkmann <borkmann@iogearbox.net>
> Cc: Yuchung Cheng <ycheng@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Andrew Shewmaker <agshew@gmail.com>
> Cc: Glenn Judd <glenn.judd@morganstanley.com>
> ---
>  net/ipv4/tcp_dctcp.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
> index cd4814f7e962..60417243e7d7 100644
> --- a/net/ipv4/tcp_dctcp.c
> +++ b/net/ipv4/tcp_dctcp.c
> @@ -67,10 +67,9 @@ static unsigned int dctcp_alpha_on_init __read_mostly = DCTCP_MAX_ALPHA;
>  module_param(dctcp_alpha_on_init, uint, 0644);
>  MODULE_PARM_DESC(dctcp_alpha_on_init, "parameter for initial alpha value");
>  
> -static unsigned int dctcp_clamp_alpha_on_loss __read_mostly;
> -module_param(dctcp_clamp_alpha_on_loss, uint, 0644);
> -MODULE_PARM_DESC(dctcp_clamp_alpha_on_loss,
> -		 "parameter for clamping alpha on loss");
> +static unsigned int dctcp_halve_cwnd_on_loss __read_mostly;
> +module_param(dctcp_halve_cwnd_on_loss, uint, 0644);
> +MODULE_PARM_DESC(dctcp_halve_cwnd_on_loss, "halve cwnd in case of losses");

Is there a reason we still need to keep this module parameter around?
The final RFC even says "A DCTCP sender MUST react to loss episodes in
the same way as conventional TCP". So it's a MUST requirement in which
case it should be enabled by default. The dctcp_clamp_alpha_on_loss was
a bit of a hack from very early days..

>  static struct tcp_congestion_ops dctcp_reno;
>  
> @@ -164,21 +163,23 @@ static void dctcp_update_alpha(struct sock *sk, u32 flags)
>  	}
>  }
>  
> -static void dctcp_state(struct sock *sk, u8 new_state)
> +static void dctcp_react_to_loss(struct sock *sk)
>  {
> -	if (dctcp_clamp_alpha_on_loss && new_state == TCP_CA_Loss) {
> -		struct dctcp *ca = inet_csk_ca(sk);
> +	struct dctcp *ca = inet_csk_ca(sk);
> +	struct tcp_sock *tp = tcp_sk(sk);
>  
> -		/* If this extension is enabled, we clamp dctcp_alpha to
> -		 * max on packet loss; the motivation is that dctcp_alpha
> -		 * is an indicator to the extend of congestion and packet
> -		 * loss is an indicator of extreme congestion; setting
> -		 * this in practice turned out to be beneficial, and
> -		 * effectively assumes total congestion which reduces the
> -		 * window by half.
> -		 */
> -		ca->dctcp_alpha = DCTCP_MAX_ALPHA;
> -	}
> +	ca->loss_cwnd = tp->snd_cwnd;
> +	tp->snd_ssthresh = max(tp->snd_cwnd >> 1U, 2U);
> +}
> +
> +static void dctcp_state(struct sock *sk, u8 new_state)
> +{
> +	if (dctcp_halve_cwnd_on_loss && new_state == TCP_CA_Recovery &&
> +	    new_state != inet_csk(sk)->icsk_ca_state)
> +		dctcp_react_to_loss(sk);
> +	/* We handle RTO in dctcp_cwnd_event to ensure that we perform only
> +	 * one loss-adjustment per RTT.
> +	 */
>  }
>  
>  static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
> @@ -190,6 +191,10 @@ static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
>  	case CA_EVENT_ECN_NO_CE:
>  		dctcp_ece_ack_update(sk, ev, &ca->prior_rcv_nxt, &ca->ce_state);
>  		break;
> +	case CA_EVENT_LOSS:
> +		if (dctcp_halve_cwnd_on_loss)
> +			dctcp_react_to_loss(sk);
> +		break;
>  	default:
>  		/* Don't care for the rest. */
>  		break;
> 


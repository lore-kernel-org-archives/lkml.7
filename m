Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E33C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B03205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMhosiCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfDDJeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:34:01 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37261 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfDDJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:38 -0400
Received: by mail-yb1-f196.google.com with SMTP id p134so27691ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0InJLt5zEX9ETbKKZeCIAMspa4OAqmASmMUMSsuwllA=;
        b=OMhosiCDg7H1c/fXGDxbs8AwaQzQNvU8pTY7oV8r3YeOFRQL962dleYjwuI3A4Tmg7
         KU5gZU+N/HoYItB8DgNuva8rRQ6xQbh4R3DLDuR/vWPi2POvFILYOFoR/NoV2EhbCwu6
         ftN5L0xqeIPPeND8Q3MK/z4peO5/RSTj+rT0G8cj7uYiebkZL95J5xtuSPZW9e9FhSUB
         FFeweFzzIjD6yriTl0tUKBYioh3B6B7/ari0mXgJc6Bw9/3ShJTDRpUCjOG/FOoTwy21
         s2p2OAIHeIb/HAqcdNQwGO7l/5tm3mRQ6IS0xRx7PH3IdU3b4W00q+rnhd1+ATYGEug5
         ORFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0InJLt5zEX9ETbKKZeCIAMspa4OAqmASmMUMSsuwllA=;
        b=i5O4RCgn2W+jLHfHTyU9qCLdicEN5TXnJksIE4m2lSgyI8+SnmN9TnF+UJqV1OWCOc
         SPa1Jpt6LnG/h1Juy84IheCwotNPkTsDiuEest6EkpzJZWdFHKHU9RZZCOXsijXv8BtR
         k+f8ctAWehBcwlxXbae13bQYZkVNjczOFIUwI1qyCxkvQwMw27jcAfP/+Sj5h+V3zuA1
         Q4oLuQlKkyFc3NQHla8EKg86+ahkk8rKz7BHJysF9M0eO5DUKkgdPxPj4IMZ/ipIR/W9
         wq87g8fyqlzUKuVplGOLgY81oAb3+67dtuJ4/TSX0GtKFxdswqyasZQgd9KgmKsKO6hR
         Hwig==
X-Gm-Message-State: APjAAAUjWFM6VcBslMXzVDqoaZhIq0529yIEctgZT70b63eXucKpIppU
        EMi7fVz4NrxkF+NOse4/gr1zk3dUGxFFLJhxJyRbLA==
X-Google-Smtp-Source: APXvYqxTO49qBPOQB7swn0ymMM1fNS91K+vmRFTivfpg5nj6c0qhRa7OEZDwrQ27FDCp30M7y6+ljVTzAZKQqdOX4vA=
X-Received: by 2002:a25:dd6:: with SMTP id 205mr4241205ybn.445.1554368857423;
 Thu, 04 Apr 2019 02:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190404082055.8981-1-olivier.tilmans@nokia-bell-labs.com> <efdc9c07-1feb-d594-7954-e4e6a379a53d@iogearbox.net>
In-Reply-To: <efdc9c07-1feb-d594-7954-e4e6a379a53d@iogearbox.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 4 Apr 2019 02:07:25 -0700
Message-ID: <CANn89iLMuk3eWa_8zqvRrB7quMJyX2Annz0tscp9hB0FPT0Vsw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Ensure DCTCP reacts to losses
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>,
        "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 1:47 AM Daniel Borkmann <daniel@iogearbox.net> wrote=
:
>
> On 04/04/2019 10:26 AM, Tilmans, Olivier (Nokia - BE/Antwerp) wrote:
> > RFC8257 =C2=A73.5 explicitly states that DCTCP should "react to loss
> > episode in the same way that a conventional TCP".
> > This is also the behavior on MS Windows.
> >
> > Currently, Linux DCTCP performs no ssthresh reduction when losses
> > are encountered. Optionally, the dctcp_clamp_alpha_on_loss resets
> > alpha to its maximal value if a RTO happens. This behavior
> > is sub-optimal for at least two reasons: i) it ignores losses
> > triggering fast retransmissions; and ii) it causes unnecessary large
> > cwnd reduction in the future if the loss was isolated as it resets
> > the historical term of DCTCP's alpha EWMA to its maximal value (i.e.,
> > denoting a total congestion). The second reason has an especially
> > noticeable effect when using DCTCP in high BDP environments, where
> > alpha normally stays at low values.
> >
> > This patch replace the clamping of alpha by setting ssthresh to
> > half of cwnd for both fast retransmissions and RTOs, at most once
> > per RTT. To reflect the change, the dctcp_clamp_alpha_on_loss option
> > has been renamed to dctcp_halve_cwnd_on_loss.
> >
> > The table below shows experimental results where we measured the
> > drop probability of a PIE AQM (not applying ECN marks) at a
> > bottleneck in the presence of a single TCP flow with either the
> > alpha-clamping option enabled or the cwnd halving proposed by this
> > patch. Results using reno or cubic are given for comparison.
> >
> >                           |  Link   |   RTT    |    Drop
> >                  TCP CC   |  speed  | base+AQM | probability
> >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=
=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >                     CUBIC |  40Mbps |  7+20ms  |    0.21%
> >                      RENO |         |          |    0.19%
> >         DCTCP-CLAMP-ALPHA |         |          |   25.80%
> >          DCTCP-HALVE-CWND |         |          |    0.22%
> >         ------------------|---------|----------|------------
> >                     CUBIC | 100Mbps |  7+20ms  |    0.03%
> >                      RENO |         |          |    0.02%
> >         DCTCP-CLAMP-ALPHA |         |          |   23.30%
> >          DCTCP-HALVE-CWND |         |          |    0.04%
> >         ------------------|---------|----------|------------
> >                     CUBIC | 800Mbps |   1+1ms  |    0.04%
> >                      RENO |         |          |    0.05%
> >         DCTCP-CLAMP-ALPHA |         |          |   18.70%
> >          DCTCP-HALVE-CWND |         |          |    0.06%
> >
> > We see that, without halving its cwnd for all source of losses,
> > DCTCP drives the AQM to large drop probabilities in order to keep
> > the queue length under control (i.e., it repeatedly faces RTOs).
> > Instead, if DCTCP reacts to all source of losses, it can then be
> > controlled by the AQM using similar drop levels than cubic or reno.
> >
> > Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> > Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> > Cc: Bob Briscoe <research@bobbriscoe.net>
> > Cc: Lawrence Brakmo <brakmo@fb.com>
> > Cc: Florian Westphal <fw@strlen.de>
> > Cc: Daniel Borkmann <borkmann@iogearbox.net>
> > Cc: Yuchung Cheng <ycheng@google.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Andrew Shewmaker <agshew@gmail.com>
> > Cc: Glenn Judd <glenn.judd@morganstanley.com>
> > ---
> >  net/ipv4/tcp_dctcp.c | 39 ++++++++++++++++++++++-----------------
> >  1 file changed, 22 insertions(+), 17 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
> > index cd4814f7e962..60417243e7d7 100644
> > --- a/net/ipv4/tcp_dctcp.c
> > +++ b/net/ipv4/tcp_dctcp.c
> > @@ -67,10 +67,9 @@ static unsigned int dctcp_alpha_on_init __read_mostl=
y =3D DCTCP_MAX_ALPHA;
> >  module_param(dctcp_alpha_on_init, uint, 0644);
> >  MODULE_PARM_DESC(dctcp_alpha_on_init, "parameter for initial alpha val=
ue");
> >
> > -static unsigned int dctcp_clamp_alpha_on_loss __read_mostly;
> > -module_param(dctcp_clamp_alpha_on_loss, uint, 0644);
> > -MODULE_PARM_DESC(dctcp_clamp_alpha_on_loss,
> > -              "parameter for clamping alpha on loss");
> > +static unsigned int dctcp_halve_cwnd_on_loss __read_mostly;
> > +module_param(dctcp_halve_cwnd_on_loss, uint, 0644);
> > +MODULE_PARM_DESC(dctcp_halve_cwnd_on_loss, "halve cwnd in case of loss=
es");
>
> Is there a reason we still need to keep this module parameter around?
> The final RFC even says "A DCTCP sender MUST react to loss episodes in
> the same way as conventional TCP". So it's a MUST requirement in which
> case it should be enabled by default. The dctcp_clamp_alpha_on_loss was
> a bit of a hack from very early days..

I agree with Daniel and Florian

Please respin the patch removing the modparam

Also please check your SOB chain

If we see :

Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>

We expect patch author is Koen De Schepper, not Olivier Tilmans

So the patch should start by 'From: Koen De Schepper
<koen.de_schepper@nokia-bell-labs.com>' if sent by Olivier.

Thanks !

Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DEC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176F2208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lws8dH71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDMPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:40:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60258 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfDMPkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AJMv/SnfHgeGPPvPpyyQCnsByRtq/H+V09Wt3JK8aqI=; b=lws8dH71OPYEElW3sd+RBaDfDM
        69dwum5sVj29lUEAIH7QW7qjzZKlKwabZYdSUfZZ7y3/vkqlvPbQoDFrfrK0Mwu8g7ISixX1Erm8E
        rn+H1vmpaCZvnnnCUxQqfzV0fsbLfGZ3OJE3iAPkgoAv+tobUkE6rpsNyvcVhryuNCoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hFKl5-0004we-Ve; Sat, 13 Apr 2019 17:39:59 +0200
Date:   Sat, 13 Apr 2019 17:39:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, georg.waibel@sensor-technik.de
Subject: Re: [PATCH v3 net-next 13/24] net: dsa: Allow drivers to filter
 packets they can decode source port from
Message-ID: <20190413153959.GE17901@lunn.ch>
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-14-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413012822.30931-14-olteanv@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 04:28:11AM +0300, Vladimir Oltean wrote:
> Frames get processed by DSA and redirected to switch port net devices
> based on the ETH_P_XDSA multiplexed packet_type handler found by the
> network stack when calling eth_type_trans().
> 
> The running assumption is that once the DSA .rcv function is called, DSA
> is always able to decode the switch tag in order to change the skb->dev
> from its master.
> 
> However there are tagging protocols (such as the new DSA_TAG_PROTO_SJA1105,
> user of DSA_TAG_PROTO_8021Q) where this assumption is not completely
> true, since switch tagging piggybacks on the absence of a vlan_filtering
> bridge. Moreover, management traffic (BPDU, PTP) for this switch doesn't
> rely on switch tagging, but on a different mechanism. So it would make
> sense to at least be able to terminate that.

Hi Vladimir

Let me see if i get this correct.

If the filter fails to match, the frame is received on the master
interface? So BPDUs and PTT packets are going to go to the master
interface?

How does the bridge get these BPDUs, and associated to the correct
slave port?

How does the PTP core code get these frames, and associated to the
correct slave port?

You say there is a different mechanism to do this. Maybe a later patch
i've not yet looked at. But cannot this mechanism be built into the
tagger? That is what the tagger is there for, to demultiplex a frame
to the correct slave. The current code assume the needed information
is in the header, but there is nothing to stop it looking deeper into
the packet if needed. So far, we have been reluctant for a tagger to
call into the DSA driver, but if need be, it could happen.

     Andrew

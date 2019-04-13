Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F3EC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EFB214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6VF4yCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDMPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:48:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45247 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 11:48:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so11542902ljd.12;
        Sat, 13 Apr 2019 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTs1VxFGCC+wF6YJAGkNVmWGX97TTBDSC2mXMy1Q4/I=;
        b=e6VF4yCl7sRu6Yd4dF/g9UKBIlujB/LS9Smgf4wksEdgkw4xkUUZ6shXBruC5e0gMu
         MX7WfNGBnyjTEUjveo/TVM0AK2QUAUOsVyN5wmt+KcdFGVqT5QmlwIBgVHDiunTz0I6u
         +3h/uolUDHzgPdbocEHkpLfVOR5UQMOd1gC+S3GfrOn6GfGqW7O35LpI8WgBCnBzdlgy
         tSGCWsjg1Vem6lqQWI8NVQK2jV8ChJBiDfgy0k+Lrx2PvxqY7dkDhA1ZHVqRutMLOXDp
         GWFdE8jot8EmXNxCCUhOo+qngKabSG0puxrQyPxuuv0ZwVIKE57pWanBlAYZGiBdHoEw
         lk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTs1VxFGCC+wF6YJAGkNVmWGX97TTBDSC2mXMy1Q4/I=;
        b=kZ59rgp2S3LS/UIbnsP6wOXROsZxQI69pKKsZGcmzcKVvl/e8SoVkxon9fhw7gJMoG
         89fgq4foInBO7gRZ4dSkkWIlgf+X9qqYhJmDNAca67j5eCpCTl8h8WI7ukECsf2RjIzm
         9RwyIkjYMUJa78/XNl3/QaHVkvKAdOoDnN3TMG57Ft6NTzIym6khGUE19LjaRcpy1I1/
         kQvWsNfCDP6vckwFpU0Cp9tM8WGsp8QtDtB5ByzSGaoxFgfic9baX5LGXnEtiC0jr2mX
         /slqzcvaQ+X9MFcdTyvZ4j9NSFdsQ4bsOq1RQUlsR0gLkpKwEakwCDSenm1EbayerI+R
         VecQ==
X-Gm-Message-State: APjAAAWV8aaLUOE0LEtxbgr5Gpt6oGTM3EgqKW3t8k+bjzylat6w9v+J
        jcPTysGdaEtS8Ls6yxZf2LjA8MKTMF6G1P5fqKY=
X-Google-Smtp-Source: APXvYqwShHhBUmIu7iWboMQZTUMVFIj2PPV7xHqVEVXJLjQj3MOsr8qDKgt7wmYMbgsmW4lt3j173oWlbNvRZcUVMZU=
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr33511754ljh.80.1555170528658;
 Sat, 13 Apr 2019 08:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190413012822.30931-1-olteanv@gmail.com> <20190413012822.30931-14-olteanv@gmail.com>
 <20190413153959.GE17901@lunn.ch>
In-Reply-To: <20190413153959.GE17901@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Sat, 13 Apr 2019 18:48:37 +0300
Message-ID: <CA+h21hqNMCzFKkdoeB0snbXY1E+BD3Rp24geuD_ZbNVPJf4kuQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 13/24] net: dsa: Allow drivers to filter
 packets they can decode source port from
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Georg Waibel <georg.waibel@sensor-technik.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2019 at 18:40, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Apr 13, 2019 at 04:28:11AM +0300, Vladimir Oltean wrote:
> > Frames get processed by DSA and redirected to switch port net devices
> > based on the ETH_P_XDSA multiplexed packet_type handler found by the
> > network stack when calling eth_type_trans().
> >
> > The running assumption is that once the DSA .rcv function is called, DSA
> > is always able to decode the switch tag in order to change the skb->dev
> > from its master.
> >
> > However there are tagging protocols (such as the new DSA_TAG_PROTO_SJA1105,
> > user of DSA_TAG_PROTO_8021Q) where this assumption is not completely
> > true, since switch tagging piggybacks on the absence of a vlan_filtering
> > bridge. Moreover, management traffic (BPDU, PTP) for this switch doesn't
> > rely on switch tagging, but on a different mechanism. So it would make
> > sense to at least be able to terminate that.
>
> Hi Vladimir
>
> Let me see if i get this correct.
>
> If the filter fails to match, the frame is received on the master
> interface? So BPDUs and PTT packets are going to go to the master
> interface?
>
> How does the bridge get these BPDUs, and associated to the correct
> slave port?
>
> How does the PTP core code get these frames, and associated to the
> correct slave port?
>
> You say there is a different mechanism to do this. Maybe a later patch
> i've not yet looked at. But cannot this mechanism be built into the
> tagger? That is what the tagger is there for, to demultiplex a frame
> to the correct slave. The current code assume the needed information
> is in the header, but there is nothing to stop it looking deeper into
> the packet if needed. So far, we have been reluctant for a tagger to
> call into the DSA driver, but if need be, it could happen.
>
>      Andrew


Hi Andrew,

Yes it's explained in a further patch. See the checks for
sja1105_is_link_local() in patch 18/24.
There's also a table in the documentation patch (23/24).

Thanks,
-Vladimir

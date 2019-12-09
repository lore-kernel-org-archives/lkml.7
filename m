Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1191C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AE22077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGoVvngF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLILLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:11:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727566AbfLILLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575889870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKNJqGYoFHuNlkkCEvoI/4LL4dAPCIC/HY9H8FJVQzM=;
        b=OGoVvngFeYFGO9jSFncwFSxBBp9GnxWTFL7gXQPj7GcBuYxa+PFgz2inzQpzEvKTeK13QI
        sjdhzZ3OmZufQNkBJGBUpvPZoTKqgMhpbVJ1rfWs4tpzZIQjgJsDpl3/re3fkhfFKNtOhA
        pDf7/HgFeGrXDR9tE740uX0uONN3LIM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-G02mOvLaOIerl92oRSOGFg-1; Mon, 09 Dec 2019 06:11:04 -0500
Received: by mail-lj1-f200.google.com with SMTP id p90so3209417ljp.23
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 03:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/XI1i3yD2ZF8jeazCNhTgJLTTX7l/kk7N2T0Iz8NsVo=;
        b=Bt12ALjfELCcOH4no5MGP8Nb6A/Ns7LAGAQ5bAsIpRR0k+UjFsRYlkyIwvfo4sJuhh
         2LFS9dRhWa5zbw2d/U/VczucZLuyTLj5ODGHZDeEgQV8X3xoVtY4dUAyoHHG1qXnv4aQ
         y3CJILSNL+LgiOwbbCrcYEt9G05EPaVUvBZlnkt4hWCSrCNmc7IAaqK7T479f5Av1KCo
         S3nARzQMiTRovBHtDH2M/xbg61eEry/Qobs41dsz9JLgy23ezMXJFAlPAw9LTghywVPi
         z8cUZOLPc1MjSYEkkMW6YfdKGRg6sJGnaLYAh6MhxKif3zbeTErZGj2gfawBTPepwhm1
         GwkQ==
X-Gm-Message-State: APjAAAV3K6AT6xdYQSC+CNf2b2EOmdRDPnvbYvr4vxjr//Zha58vT6sT
        p8jQnkAVpXQi9os/jGzvFSHOyOWI0m3BzKbGM8g0e/u7Ihv+Qbpls+wV2LUL+bg+R4lIWHpEp25
        iO6aysaBXawRyU2R6e/Lr7J0c
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr17195080ljc.87.1575889862614;
        Mon, 09 Dec 2019 03:11:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz7+idSyfFRccLmSN8y783VRquoHKeJhGew9SSKWdah45sGBl7BuznHHfRp0fUYiD+0/fR8A==
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr17195059ljc.87.1575889862292;
        Mon, 09 Dec 2019 03:11:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v9sm4240067lfe.18.2019.12.09.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 03:11:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B41A18257B; Mon,  9 Dec 2019 12:11:00 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: 5.5-rc1 oops on boot in 802.11 kernel driver
In-Reply-To: <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com>
References: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com> <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 12:11:00 +0100
Message-ID: <87h829lpob.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: G02mOvLaOIerl92oRSOGFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Hi Steve,
>
> Steve French <smfrench@gmail.com> writes:
>
>> Noticed this crash in the Linux kernel Wifi driver on boot a few
>> minutes ago immediately after updating to latest mainline kernel about
>> an hour ago. I didn't see it last week and certainly not in 5.4.
>
> please CC linux-wireless on all wireless related problems, we don't
> follow lkml very closely and I found your email just by chance.
>
> Full warning below. Steve is using iwlwifi.

Right, we already got a similar report off-list, but with a different
stack trace. I was going to try to reproduce this on my own machine
today. However, the fact that this includes the iwl_mvm_tx_reclaim()
function may be a hint; that code seems to be reusing skbs without
freeing them?

If I'm reading the code correctly, it seems the reuse leads to the same
skb being passed to ieee80211_tx_status() multiple times; the driver is
clearing info->status, but since we added the info->tx_time_est field,
that would lead to double-accounting of that SKB, which would explain
the warning?

Can someone familiar with iwlwifi confirm that this is indeed what that
code is supposed to be doing? If it is, I think it needs the patch
below; however, if I'm wrong, then clearing the field could lead to the
opposite problem (that skbs fail to be accounted at all), which would
lead to the queue being throttled because the limit gets too high and is
never brought back down...

-Toke


diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/tx.c
index dc5c02fbc65a..7d822445730c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1848,6 +1848,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, i=
nt sta_id, int tid,
                iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
=20
                memset(&info->status, 0, sizeof(info->status));
+               info->tx_time_est =3D 0;
                /* Packet was transmitted successfully, failures come as si=
ngle
                 * frames because before failing a frame the firmware trans=
mits
                 * it without aggregation at least once.


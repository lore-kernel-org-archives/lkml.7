Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E9C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EDF2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrlcNg0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfLIOKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:10:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22662 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbfLIOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575900616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8MHeSmErGIjySHPAAzp+CJ/YCYvZDrefSPRZN4SlDA=;
        b=QrlcNg0Mlxm3t5sgINgeoTGRE03XJtbjlH6oB3LqS6+TkgPsunV50/oNOjrFkBC/Pbm8cu
        6D4UgaEZ24uigEf3ST5NLmbvYrkjxft0RARkXqpdVWPnplofeYYWoY0tX/XSXyzICTo5ck
        Q3pwgrrmZ7/xVb388Ae/FFSvC0sRjnw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-6wiH1DbDMsqfdLsu_DMYhA-1; Mon, 09 Dec 2019 09:10:15 -0500
Received: by mail-lf1-f70.google.com with SMTP id q3so2894699lfb.21
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=E8MHeSmErGIjySHPAAzp+CJ/YCYvZDrefSPRZN4SlDA=;
        b=L3xUchrh3PfxVgQpQcHCVjHYk5XujEcloaQGtkvtl+PYFYNYqyry4sbJU3Su0AUvIO
         94ctPzedeP3AWUV47LgHnPPNO8ut3dpa7qar5/LZD8rAwFyZv1Xvje7tl4JmKEE81dQI
         iP0eB8us+IUixq+ZGk1vbi0PpU+NX7smxclc+XDRVUHuPbGp6S2FDWSTBUWF04TPfaej
         Ljn8Qjd1YKA/XvVCTnsoAbF5EZpicAwp+34GQOC5nY5RnRM9BKUqMbq/f4UA8ImTESqF
         MmhIIsGNc/Z0CseFEbFm4pYM+D/gI1fkkGvSQlGPqiftt1bW/O1psmvu1bEvovqzE6d2
         am/g==
X-Gm-Message-State: APjAAAXWRT/uULFAH8OvoQ0I5NWIbb1VPnoETTq4ERpSso9BooM83fkm
        cpF2prLpzxbzADRmB0aInMJsAjBfb0/S39hUdHbxJHbZumSRNVwazi498yoDDirtvPDyhiPH1uh
        wEECwMbbY9YlRCnsYd9ifGvmv
X-Received: by 2002:a2e:5850:: with SMTP id x16mr17025787ljd.228.1575900613926;
        Mon, 09 Dec 2019 06:10:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbgId3BcY2VrxCOO3tOzW3tTJ8ze5gQc8m0QowN0hydiXJKpH9z/cbAknaAe2Dzi4DnaAxQg==
X-Received: by 2002:a2e:5850:: with SMTP id x16mr17025767ljd.228.1575900613666;
        Mon, 09 Dec 2019 06:10:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r2sm10989213lfn.13.2019.12.09.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:10:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2182D181938; Mon,  9 Dec 2019 15:10:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: 5.5-rc1 oops on boot in 802.11 kernel driver
In-Reply-To: <87h829lpob.fsf@toke.dk>
References: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com> <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com> <87h829lpob.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 15:10:12 +0100
Message-ID: <87muc1io8r.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 6wiH1DbDMsqfdLsu_DMYhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Hi Steve,
>>
>> Steve French <smfrench@gmail.com> writes:
>>
>>> Noticed this crash in the Linux kernel Wifi driver on boot a few
>>> minutes ago immediately after updating to latest mainline kernel about
>>> an hour ago. I didn't see it last week and certainly not in 5.4.
>>
>> please CC linux-wireless on all wireless related problems, we don't
>> follow lkml very closely and I found your email just by chance.
>>
>> Full warning below. Steve is using iwlwifi.
>
> Right, we already got a similar report off-list, but with a different
> stack trace. I was going to try to reproduce this on my own machine
> today. However, the fact that this includes the iwl_mvm_tx_reclaim()
> function may be a hint; that code seems to be reusing skbs without
> freeing them?
>
> If I'm reading the code correctly, it seems the reuse leads to the same
> skb being passed to ieee80211_tx_status() multiple times; the driver is
> clearing info->status, but since we added the info->tx_time_est field,
> that would lead to double-accounting of that SKB, which would explain
> the warning?
>
> Can someone familiar with iwlwifi confirm that this is indeed what that
> code is supposed to be doing? If it is, I think it needs the patch
> below; however, if I'm wrong, then clearing the field could lead to the
> opposite problem (that skbs fail to be accounted at all), which would
> lead to the queue being throttled because the limit gets too high and is
> never brought back down...

Right, and now I did boot up my own laptop with the -next kernel, and
tested the patch. It definitely breaks things, so that was not the
issue. However, I don't get the WARN_ON either, so don't have any better
ideas. I guess we'll have to wait for someone who actually knows the
iwlwifi driver to take a look at this :)

-Toke


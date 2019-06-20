Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C87BC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0A42083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Dr1m2XMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbfFTMAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:00:44 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41195 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:00:44 -0400
Received: by mail-wr1-f52.google.com with SMTP id c2so2729715wrm.8;
        Thu, 20 Jun 2019 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ixHJcWrb7vbhPVhlSAqKWedyHn0suxaA9sUxRx8L9U=;
        b=Dr1m2XMuDVTw6R8jkFwqlLKeVfQREHFlQL+G6MGtCPY0rzG/azqy0ZIDSbk5Gw21II
         mD8mITqv1C6koK9TifHhRzfRu5N6dyGAe8HBfCLDTxqNng+ZXqIIvh/tKJjsSqsd34sJ
         XLSUiVsh1Zu0p+fhtySqST2sQp3dYqUAzPg7HhGG5ZJ43JURBdhx6+eindWSGdKHzait
         cH4GOaPaQboS5kPHGdO/TP4FhYnDM0li4dWLWYRjwyQAOOT/wK4OiFPmyr51qBOMd7Vb
         FI8vOOwofWitTg/AiO4VnQyVPGQ71d2sor6h8UrTfE1dcVUKW7Pb8ZV49bFEudaarQaX
         OPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ixHJcWrb7vbhPVhlSAqKWedyHn0suxaA9sUxRx8L9U=;
        b=Jk6aYWy2MqDM6z4RFEp3eHrAOrNalE0FBtGbcindOunY99lJ7YlGrIptU4GPeJAd9S
         pQTJE3QpJRPdePV3b/5XD6ptjIp7Uh9Z/asews9BiuSfWDiq/FWgtn2NrriE2fPNFSR5
         24fCtzhWC6JWnBNa0vPgVo63yx7dLeSOkxYk7tcJ/SpRWF93ucwYKggiOZStEUS3jwBD
         s5Ip704kJ+NImtWZixxnwDG8fohZOalK6dwBiHMgyU3OUkW4wvHkrmqd6KXuhmyYBOvD
         1ALCKUSc0O/hvFql4NEZ6XYX9na4P11QYWwG8sRo40/7WQlbT6g5IivlRfBifMY+GzVH
         +B/Q==
X-Gm-Message-State: APjAAAXT5wuAO/l2M4MsaWWeAt1CsNYzAkgBWSpkqmC98jbv9xlLwhG7
        insuZYY0FHietV6gg1n38ls=
X-Google-Smtp-Source: APXvYqyHKw+CR/XUVijOlUr2j3a6GGNYpBd7RqXZJTTytEYNY41EKSyOvPROsyfA/XbdZTYXG9Dbsg==
X-Received: by 2002:adf:f946:: with SMTP id q6mr5177141wrr.109.1561032042186;
        Thu, 20 Jun 2019 05:00:42 -0700 (PDT)
Received: from [192.168.201.5] (p4FD256F8.dip0.t-ipconnect.de. [79.210.86.248])
        by smtp.googlemail.com with ESMTPSA id 5sm27148341wrc.76.2019.06.20.05.00.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:00:41 -0700 (PDT)
Subject: Re: (Small) bias in generation of random passkeys for pairing
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        security@kernel.org, linux-bluetooth@vger.kernel.org,
        johan.hedberg@gmail.com, marcel@holtmann.org
References: <20190619162456.GA9096@amd>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Openpgp: preference=signencrypt
Message-ID: <66098773-4d88-ebdb-02d5-8af0cc4ea99c@message-id.googlemail.com>
Date:   Thu, 20 Jun 2019 14:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619162456.GA9096@amd>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Am 19.06.19 um 18:24 schrieb Pavel Machek:
> Hi!
> 
> There's a (small) bias in passkey generation in bluetooth:
> 
>                 get_random_bytes(&passkey, sizeof(passkey));
>  		passkey %= 1000000;
> 		put_unaligned_le32(passkey, smp->tk);
> 
> (there are at least two places doing this).
> 
> All passkeys are not of same probability, passkey "000000" is more
> probable than "999999", but difference is small.

It is slightly different IMHO.

Unsigned 32bits passkey assumed (and all users I found were u32),
the passkeys "000000" to "967295" are slightly more probable than
"967296" to "999999".

If my math is right (which I doubt), the difference in probability
for both entities is 4294:4293.

> Do we care?

I, personally, don't (yet).
But then, I'm not a real security expert.

Have fun,
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman

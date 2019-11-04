Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A67CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DDB217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1AGCyL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfKDKyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:54:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45945 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfKDKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:54:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id x21so23164129qto.12;
        Mon, 04 Nov 2019 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=U3NS7MGRIDkdoS3eVjdQC4auRnoPi6aRNIBzXWaDMUE=;
        b=f1AGCyL66sDJi3QUXxW2C+ewwVr/gz97WvEN9hg1hZmrHWH8t0qqUB3Np2IKkNUTUo
         JteKf2otKbtU9ZsyQ5yao8hhuxqmMSF1MgG0BkaZrj/+NaF//oZ53XD46btksqxPXo2r
         8PquRcKm7CLNb6bfl8FVAjFgAUDp1Z/rlD3jyLfNxo5BQtyoMsfsMU6iDvI8okXxS22X
         X2+lcgTtHvwgFCu981JF8laaHC2tUw+bpvBwS+9rHeQ7EEJnCT3/l22xwGLJnENfDL1M
         DMHYbLjKok3ASVFj+MjB14yWY9QJl+TyWyh4R4bIE2FFYWff3PmMaGFMcaFtU7VXUL0G
         mWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=U3NS7MGRIDkdoS3eVjdQC4auRnoPi6aRNIBzXWaDMUE=;
        b=XEKijz7tAKJiLPaBhUfYosr5PXRDUFq7x9SyFiqGSuVaDjjweh8gHoWOcmalTd+Rgg
         kU7M1eOJVC+Z4+M/HLI7w8KZj5fH1etDI36hquVXqPjN+PmmCj9UY+bTpOrhcW23CWIc
         s81AQH6rB/+neb5Q6Qe+BZBaYaI1LsJ5uESdFvxqxQqj5t/qDd+h4uWvMpuUwgoQlmuG
         fDgjSVJWLhBUhLYIg6GtOfvCxhRLE1SxnTxylG+HjJ9eQts3EqyPKQwZZFqHcC0V1fwg
         TQRx3JcAlIXylTfDf4mANsxx9wPGTEOzxe82KeiOboO990CNam131B79tuF9faJox/o6
         IfHg==
X-Gm-Message-State: APjAAAVqw0yGE7aaMAsdU1BNcdrcPcW2Fp9Ylcagn3XUdAFEN0x8f+Bx
        yNo8l4X75Q4XKo8G3nMYfPOtB4wAxQ/Oe4S91H3CjxN+9UE=
X-Google-Smtp-Source: APXvYqzpQhNSh561vwWXcRjBjo44kQZ6WKt6h68IsV5eiH59WYV6BVHCwdzzzK1+/p462ZjDI/vrSS749lYeeSC6k6o=
X-Received: by 2002:a0c:c3c4:: with SMTP id p4mr22067194qvi.178.1572864877195;
 Mon, 04 Nov 2019 02:54:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
In-Reply-To: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
From:   Leon Maxx <leonmaxx@gmail.com>
Date:   Mon, 4 Nov 2019 12:54:26 +0200
Message-ID: <CAPW-Pu0qCfNXwjDW90To5ZpwtfpXAzm93CWFaUvA_9YQW5Ke-g@mail.gmail.com>
Subject: [RFC PATCH 1/3] platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, andy@infradead.org,
        dvhart@infradead.org, corentin.chary@gmail.com,
        Daniel Drake <drake@endlessm.com>, yurii.pavlovskyi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fan_boost_mode_store should return number of bytes written
but instead it returns return value of kstrtou8 which is 0 if
conversion is succefull. This leads to infinite loop after any
write to it's SysFS entry.

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..723aa4d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1718,7 +1718,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
  asus->fan_boost_mode = new_mode;
  fan_boost_mode_write(asus);

- return result;
+ return count;
 }

 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
1.8.3.1

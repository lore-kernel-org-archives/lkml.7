Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3844AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C572175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLUWNS1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfDXLnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:43:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44428 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfDXLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:43:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id s10so9007526qtc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wGK5Ub5N8HF3VeoujLt1WRTNlmtW8D+nRF2cORxNps=;
        b=XLUWNS1ir3CSFZwxFamJXa8kDbaOO7GcRGFi/VpkVZyIlRvlUWJeptzewiDa8Tqkyg
         SXZr+0UH5fmHNo3MH/0hb2cAv8vDSLfN7nvDBd4r++C3oLW7CTYUe1TZW/oS11QpV6hM
         hmySWpY+xJGI/A7354hN/C4QbBiUR1NWgUT7bH5KZM8XOAnD4crzG6QyLMmCR39I2AeQ
         hCRn1CyUJNf77nSCm0gCtYqqsZj9upC/X2TD60Zybn5mB0FyV8dOLQe5Keuwq0t4xAFE
         rZ8J7dg3QNYQexFBZrqaHCGiG2VWZeXuR19oiHShK/1sMdY1sZArP27CwXBXZgyjZ666
         ASlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wGK5Ub5N8HF3VeoujLt1WRTNlmtW8D+nRF2cORxNps=;
        b=dm4ELpmPZHqQHA2l1VTyjruxp0X8BsLaw6GAIa5lAJp9n1tHdj9JoH3Ozfzwm+SBVN
         QI4dIWW6V/CeVh4CLkHTwD87Ish0UO5u9/xpbv89CckbRUL+uGOcHDkC9MlQh4f9aLeE
         DdFv2VLAUqaPJ/P3stTxrvoiGNaUqmhaY3mWNe5e6Co6jb79nMDL/PzT/JXNHIETDjac
         CVKEE14p5533ANZuqYmTu/AAYKddm0pon8uyIRJtC6/JTICYOoNZqqDczLQ93D2GTdJM
         H00FcIhwq2vRtOGuQnJ/WkvGAFTzR6ZmsB4MwkMo8HHqPti8V+CJ+/h/F8kPulAwRMSf
         v1XQ==
X-Gm-Message-State: APjAAAWLVBrEFIPq+paVxpt9bgq6A04axurLMWNp+DnFos/nAoah+FJ7
        Y9dtF+lWmrVxQ9AKBs7Z6bx6MjqsydL8JvmCTXg=
X-Google-Smtp-Source: APXvYqwz54vAMgIsBY6C90mw52lci11QY2/N7hJtPuVqJ/JRjMoGQVaxxua4Pg92crWTXF20SQT62TzXmuZlbEvwBjM=
X-Received: by 2002:ac8:4603:: with SMTP id p3mr18745290qtn.4.1556106219897;
 Wed, 24 Apr 2019 04:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190422093353.61014-1-yuchao0@huawei.com> <20190422093353.61014-2-yuchao0@huawei.com>
In-Reply-To: <20190422093353.61014-2-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Wed, 24 Apr 2019 20:43:29 +0900
Message-ID: <CAD14+f0D9CVmBZGmbMcKB7xAHvBrbGAgVxR4W8Fiu0Vo6czDYQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: relocate chksum_offset for
 large_nat_bitmap feature
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Apr 22, 2019 at 6:34 PM Chao Yu <yuchao0@huawei.com> wrote:
> +       if (__is_set_ckpt_flags(*cp_block, CP_LARGE_NAT_BITMAP_FLAG)) {
> +               if (crc_offset != CP_MIN_CHKSUM_OFFSET) {
> +                       f2fs_put_page(*cp_page, 1);
> +                       f2fs_msg(sbi->sb, KERN_WARNING,
> +                               "layout of large_nat_bitmap is deprecated, "
> +                               "run fsck to repair, chksum_offset: %zu",
> +                               crc_offset);
> +                       return -EINVAL;
> +               }
> +       }
> +

I try not to be a Grammar Nazi and a jerk on every patches, but since
this is a message a user would directly encounter, I'd like to see a
bit less ambiguous message.

How about "using deprecated layout of large_nat_bitmap, please run
fsck v1.13.0 or higher to repair, chksum_offset: %zu"?
The original message seems to suggest that large_nat_bitmap is
deprecated outright.

Also, I'd like to suggest to write down an actual version of
f2fs-tools here as we've seen older versions of fsck doing even more
damage and the users might not have the latest f2fs-tools installed.

Btw, what happens if we use the latest fsck to fix the corrupted image
and use the older kernel to mount it?
Would it even mount?

Thanks.

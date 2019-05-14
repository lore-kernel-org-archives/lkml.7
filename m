Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A635BC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0E32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 01:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HibJBWcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfENBhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 21:37:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42027 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfENBhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 21:37:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id j53so17136620qta.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SOOeaKMfw8I0MoiLwEapADtrXGn7pkhV0kap6ZwQVDI=;
        b=HibJBWcd5fNtFy3dxGVSTMny3QlEzBW7sojDuTKzkZICspt0QMxzQlk2MahyCp0lVt
         nkGFODLkNk7BMSA/Xbo27hzTtDWKf0LlyQps9VVAIUK0hh0LbLk3P4vDVpSSMyZxqRQ1
         ZyShH8xVWk5x3UEAvW+2f1rdSdPwDl+Tyl4jZo6YdNPy7E7JQJ4nDSzZvRhesJpvRbS1
         Ygz9/z1lUkAiroY8RbYOn5T+Nmo0/0EUQeVqSjrtWFW+dnB+gTHinouDGz8xfqrgHrHG
         vFhLVujQechPkBFoNmO3m1CVAWmUJFZ26hUNhAboAabZfJPED7N/a2TbSfcmUml9Fg7X
         1G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOOeaKMfw8I0MoiLwEapADtrXGn7pkhV0kap6ZwQVDI=;
        b=Aippq6BqChaKhf/tBqaO0XjlSWyu+ATmMCvNxw0X7BuO7nw0W6PHZdSgzFHyFuO/t4
         PbzkYQ0eKYVzjiQCH+ADc1MU3P4Sj1h9BLK+C8OMqBboOnWch8fVOhcVo8mkuZzeKHND
         S29vQL9z0Sm8M2y2MNOqKsJemU8oM8dpDZzx8oNGYNY/BlCIsLkdwPzD852ZP2cZyI8O
         CMItAB1a/2a9MKJrFNONu0n4qGSxse95c3vaICh1sL/EZgFdP1SQ7iaVTGuqiJMEfthu
         SKN480+CGMu6am3YZzVJs17CTWL30cXI1qdAVBycatf/QEHyb1artxEMqglp0QwoRi7y
         nQ2g==
X-Gm-Message-State: APjAAAUz6Dp7k0pPvaP3pso8OmnLO/CAfcd04q2cUqKtDkJo/U8gZfh8
        OKALtqTXSbLPt8fgADemVcjZwDaz
X-Google-Smtp-Source: APXvYqx59YutmMKXaNr3D4cWZm83/Tz4GquDTc15cehb6DgVneMJGcUPloa/Q4XA8id6LKgMl4bYdA==
X-Received: by 2002:ac8:2687:: with SMTP id 7mr4387486qto.325.1557797838761;
        Mon, 13 May 2019 18:37:18 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z8sm8208376qth.62.2019.05.13.18.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 18:37:17 -0700 (PDT)
Date:   Mon, 13 May 2019 21:37:16 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dm-devel@redhat.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: Re: dm ioctl: fix hang in early create error condition
Message-ID: <20190514013716.GA10260@lobo>
References: <20190513192530.1167-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513192530.1167-1-helen.koike@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2019 at  3:25P -0400,
Helen Koike <helen.koike@collabora.com> wrote:

> The dm_early_create() function (which deals with "dm-mod.create=" kernel
> command line option) calls dm_hash_insert() who gets an extra reference
> to the md object.
> 
> In case of failure, this reference wasn't being released, causing
> dm_destroy() to hang, thus hanging the whole boot process.
> 
> Fix this by calling __hash_remove() in the error path.
> 
> Fixes: 6bbc923dfcf57d ("dm: add support to directly boot to a mapped device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> 
> ---
> Hi,
> 
> I tested this patch by adding a new test case in the following test
> script:
> 
> https://gitlab.collabora.com/koike/dm-cmdline-test/commit/d2d7a0ee4a49931cdb59f08a837b516c2d5d743d
> 
> This test was failing, but with this patch it works correctly.
> 
> Thanks
> Helen

Thanks for the patch but I'd prefer the following simpler fix.  What do
you think?

That said, I can provide a follow-on patch (inspired by the patch you
provided) that encourages more code sharing between dm_early_create()
and dev_create() by factoring out __dev_create().

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index c740153b4e52..0eb0b462c736 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -2117,6 +2117,7 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 err_destroy_table:
 	dm_table_destroy(t);
 err_destroy_dm:
+	(void) __hash_remove(__find_device_hash_cell(dmi));
 	dm_put(md);
 	dm_destroy(md);
 	return r;

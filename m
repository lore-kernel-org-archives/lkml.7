Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B69C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDE3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7irfG7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfDWQU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:20:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44961 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:20:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so5200015plk.11;
        Tue, 23 Apr 2019 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RITjfCM/Fak6Gm6jLLNcOvzNIx+YHi5oeUMpgO8y9jY=;
        b=R7irfG7f/p76B0rFKLBRyyDlIYiyMMbGwFsbZDfS4LTP1pV+NERE2mF0UykwJZr+21
         Rr9Uft50P4MPwWUw97hhHaKWgbZhZ36+16nXX62mI806Fu82P8KoQ7aiaEF2lp1J2Ojn
         VzQLHrMfX3dFx3dJwIeTi2sRfrzxMfN2LZT+KPPpZaU22SULINr9DDjI8lJu7gfgb/VK
         Std4YfrCHYTkBnXw+Ty3zJZFpnCGdupxnmKTpNDW/PC20J4Z0sK4UgjqSAm+81cNsUM/
         RUAivKxgBe5YNjhFKeLmQ2hiQbYihe7HzX0sp+R9A9OXFkFOi56xHD53T/CaLlhsJR6w
         6mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RITjfCM/Fak6Gm6jLLNcOvzNIx+YHi5oeUMpgO8y9jY=;
        b=I6uneTSuRs549WIDRpOvDFCDrswN4q6xuT5cqPAl1xAdzIHTM199vlroi6JPksGx42
         2al3VthyNxmjSy0iNc1rDg1cF8FdT1cpe45Sgn1KrCXlZOE04KN6TkUXm+tJWeg8M8o1
         YXVlrEQssmGn9afpGAtbnA4rYFChN63vK1xotRv2lnvEB7+nSsLtP9SbtCip/XhoMFLT
         pP3fuoof5xXWRdUbezMdgD0JM6iz7yPTPsjUXmkukw19zNFhmXrm8OBxcH/1aNq1PeEG
         J678AYNccAYGGsDpELbZKdEMXRqUs8DhzibcwqJI0UdHLTLDD/ke+/AD4G3EREF7q9H6
         0vEw==
X-Gm-Message-State: APjAAAW+eBTyfEneV7MHrgFKTKAAePXgbyACU5UK1gLYgutBoImoYyV9
        TEgpwVPkJGleFBQFwV60Meo=
X-Google-Smtp-Source: APXvYqwxs1DM5T06SgOAm/pgJ69znoQj8RO5A6HeKRvbpmW1B1NXbfb04rdjUwM7M8PXHc6+dQZpbw==
X-Received: by 2002:a17:902:54c:: with SMTP id 70mr27368007plf.210.1556036457734;
        Tue, 23 Apr 2019 09:20:57 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id 75sm25949979pfr.55.2019.04.23.09.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:20:57 -0700 (PDT)
Date:   Tue, 23 Apr 2019 21:50:45 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: Add comment to explain endianness issue in
 xattr_hash
Message-ID: <20190423162045.GA15509@bharath12345-Inspiron-5559>
References: <20190423161831.GA15387@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423161831.GA15387@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:48:31PM +0530, Bharath Vedartham wrote:
> csum_partial() gives different results for little-endian and big-endian
> hosts. This causes images created on little-endian hosts and mounted on
> big endian hosts to see csum mismatches. This causes an endianness bug.
> Sparse gives a warning as csum_partial returns a restricted integer type
> __wsum_t and xattr_hash expects __u32. This warning acts as a reminder
> for this bug and should not be suppressed.
> 
> This comment aims to convey these endianness issues.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  fs/reiserfs/xattr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
> index 32d8986..0ea6654 100644
> --- a/fs/reiserfs/xattr.c
> +++ b/fs/reiserfs/xattr.c
> @@ -450,6 +450,16 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
>  
>  static inline __u32 xattr_hash(const char *msg, int len)
>  {
> +	/*
> +	 * csum_partial() gives different results for little-endian and
> +	 * big endian hosts. Images created on little-endian hosts and
> +	 * mounted on big-endian hosts(and vice versa) will see csum mismatches
> +	 * when trying to fetch xattrs. Treating the hash as __wsum_t would
> +	 * lower the frequency of mismatch. This is an endianness bug in reiserfs.
> +	 * The return statement would result in a sparse warning. Do not fix the sparse
> +	 * warning so as to not hide the reminder of the bug.
> +	 */
> +
>  	return csum_partial(msg, len, 0);
>  }
>  
> -- 
> 2.7.4
>

Is this good or is it lacking any explanation?

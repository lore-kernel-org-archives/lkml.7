Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7465CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B044222C1
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="K4yRjbQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409498AbfJYQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:32:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44731 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbfJYQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:32:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id c4so3370137lja.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aUvEx9HZvsTIgPUyMH5XlBDc9GALQrMIKIvZ3DuSPEE=;
        b=K4yRjbQEIhHrz72615nejLKsPfEKEXSttAY8z13wpdqpymVE4fAgpjXH577G8erpJp
         pnWCcDd56eyjzLXuNN8ftFCqXRQDoJuE23SGVLLpYnEnt7DOTa9P0mK9yp3SvwJF5Gh/
         duKOZsYXF0jtGsL/T1jLYXH4gVR00Sa1cRbNfy+/k8gKPHMRj2fNk3DP88GFHDk10I+V
         S3K+QL7e3B5uL4iSV4qJx/HbGlImKWxScqyMEBAQxYIKN7Xm5D13SAwrKE6Q7lR+RDjE
         kD/4LpGdtYUh3Xm2saT3p6A/MB+mcARzhaQtfTt5IHXxaT5sBNfLUHJDOgGJZFZZJ+RL
         dRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aUvEx9HZvsTIgPUyMH5XlBDc9GALQrMIKIvZ3DuSPEE=;
        b=eHT6ggpRShWncGfq64IfBWvzRWuJcB9D3+CQy1CwqNpnccIhVKp0hiC797MV5W0eeo
         912T1aZ8n0nw4jDPLFr/C6rM6UqRqdxvZUXw+dtgFRcdc2W7hUSJMoMFcvxUrg2sdsJa
         7kpw1Rp1yCbN/yZuTwf8+Y4YvIFFxeGpxUHx1S+KUdA/0U1F6EyuUFl/tXn1XWeO2Bpf
         F7oIONN/ozCy1FIYUe41NZPJnKhOS8ZLRivqMI8z4XNG93GdHe5PKd60nxISoNnumPDU
         RxZh85WkqJTHnZ5ceNGmFbbGcEyHL0EnHtWGJoeYJnBnmOtQv8pD81tdbLs8hrSoEBe8
         32xw==
X-Gm-Message-State: APjAAAUCBrwCIGNXW5vlemURWps0ARusBbSQPpkOBvLcikL5dg+UTOhZ
        bY7Indw31IbzxWcbaHUSHcUoqw==
X-Google-Smtp-Source: APXvYqx5yh5D5PJ2m8iKys+639ad4qNRhItdC2ximujxlbmn+F6Uufeub3RzZ8JPxk2mQn+TrBH/IQ==
X-Received: by 2002:a2e:8654:: with SMTP id i20mr3121136ljj.238.1572021154458;
        Fri, 25 Oct 2019 09:32:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y28sm984004lfg.31.2019.10.25.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:32:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7864010267F; Fri, 25 Oct 2019 19:32:33 +0300 (+03)
Date:   Fri, 25 Oct 2019 19:32:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map
 gone
Message-ID: <20191025163233.myl7kcgz25qsbnwm@box>
References: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191025153618.ajcecye3bjm5abax@box>
 <74becfc0-3c34-bdd2-02cd-25b763c92f3b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74becfc0-3c34-bdd2-02cd-25b763c92f3b@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:58:22AM -0700, Yang Shi wrote:
> 
> 
> On 10/25/19 8:36 AM, Kirill A. Shutemov wrote:
> > On Fri, Oct 25, 2019 at 01:27:46AM +0800, Yang Shi wrote:
> > > File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
> > > the flag is never cleared until the THP is freed.  This result in
> > > unbalanced state although it is not a big deal.
> > > 
> > > Clear the flag when the last compound_mapcount is gone.  It should be
> > > cleared when all the PTE maps are gone (become PMD mapped only) as well,
> > > but this needs check all subpage's _mapcount every time any subpage's
> > > rmap is removed, the overhead may be not worth.  The anonymous THP also
> > > just clears PageDoubleMap flag when the last PMD map is gone.
> > NAK, sorry.
> > 
> > The key difference with anon THP that file THP can be mapped again with
> > PMD after all PMD (or all) mappings are gone.
> > 
> > Your patch breaks the case when you map the page with PMD again while the
> > page is still mapped with PTEs. Who would set PageDoubleMap() in this
> > case?
> 
> Aha, yes, you are right. I missed that point. However, I'm wondering we
> might move this up a little bit like this:
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d17cbf3..ac046fd 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1230,15 +1230,17 @@ static void page_remove_file_rmap(struct page *page,
> bool compound)
>                         if (atomic_add_negative(-1, &page[i]._mapcount))
>                                 nr++;
>                 }
> +
> +               /* No PTE map anymore */
> +               if (nr == HPAGE_PMD_NR)
> +                       ClearPageDoubleMap(compound_head(page));
> +
>                 if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
>                         goto out;
>                 if (PageSwapBacked(page))
>                         __dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
>                 else
>                         __dec_node_page_state(page, NR_FILE_PMDMAPPED);
> -
> -               /* The last PMD map is gone */
> -               ClearPageDoubleMap(compound_head(page));
>         } else {
>                 if (!atomic_add_negative(-1, &page->_mapcount))
>                         goto out;
> 
> 
> This should guarantee no PTE map anymore, it should be safe to clear the
> flag.

At first glance looks safe, but let me think more about it. I didn't
expect it be that easy :P

-- 
 Kirill A. Shutemov

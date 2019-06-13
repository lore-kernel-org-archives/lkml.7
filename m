Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6141AC46477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3444220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="j+R1Ourb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbfFMPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:05:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42079 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732454AbfFMOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:16:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so31459987edq.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zfhq9IiJVXNf+QOeCjoULwGTOfODIGNFGM6oVnHaXNQ=;
        b=j+R1OurbstKu0RisgFzmTieJxezTh38rMAEcoHHGEtWuRAHY1jSiKRk9u0yjhC/Ciq
         TEU0UX/Lfdt3ZseHghTCjBbkesFN74T4YpM2PvJEfxXiKZMDThB4PGip3lRNtVmusSgn
         l///05m1QHZDyuZ5bqmT0uWQn94nmyzU49DjM7sxe0xq1u+LUnjaJNyjK1+P6xBW28F2
         WUNQHW0TtRKQrSVzTYV3WKucjM22LUJS5YW7ltFSBls+Nio4gnjC0sQz/FRHm22uRuA7
         T1qgmKJp2N15PVRkMz6fiVWzqh7CUJjWpUtQjGzyoBGoqETZgipQIWtIcOztNGOghet4
         IBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zfhq9IiJVXNf+QOeCjoULwGTOfODIGNFGM6oVnHaXNQ=;
        b=UBX9tpjEaiU/L4NsrmnaN2vxtf6eokL1RPfkwkF9SXyboDh3vlqHizvTH1IlXio8wL
         tOTX/RVbeKbWT3IRbL+qZL7pAslT1y86vJ79eEWgQOMCOPLWKXF/+mX57O0ohNBfbetl
         Zg2ILRjI61eGZuLwFHOVUViG8n/QaIzpfTTkXm5X4H3R6DZsOfQ0Zs70RaFzYbsSAiy+
         iEWhajXsj5qmvSroRPaWUkba5RjzBGEh7Lpy1T4wnxpqN5FO4Cp+ZXwNSd0H71l5In2s
         mM2gMu7fcPwumqIyaJwIlKllbEuNn5GvkMhYYu1TRqjde0E8t60g2mojmdH+jz/Q41+E
         d9iw==
X-Gm-Message-State: APjAAAUvlvqpu6jZladmZelfsGBnj615K0XnnlexdpdmPX/RcyjL7Lpd
        UWkXslGoDX207nbQjuZe/djtAQ==
X-Google-Smtp-Source: APXvYqwr7X7rGeuhCIrwmc+ByVKc9dYLxDyik1ORrso48GpusnstzcW6+rBMZcR9NMFID6ciUHVHyA==
X-Received: by 2002:a50:b68f:: with SMTP id d15mr20174528ede.39.1560435377459;
        Thu, 13 Jun 2019 07:16:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c49sm374958eda.74.2019.06.13.07.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 07:16:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ECB431008A9; Thu, 13 Jun 2019 17:16:15 +0300 (+03)
Date:   Thu, 13 Jun 2019 17:16:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "namit@vmware.com" <namit@vmware.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 3/5] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190613141615.yvmckzi3fac4qjag@box>
References: <20190612220320.2223898-1-songliubraving@fb.com>
 <20190612220320.2223898-4-songliubraving@fb.com>
 <20190613125718.tgplv5iqkbfhn6vh@box>
 <5A80A2B9-51C3-49C4-97B6-33889CC47F08@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A80A2B9-51C3-49C4-97B6-33889CC47F08@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 01:57:30PM +0000, Song Liu wrote:
> > And I'm not convinced that it belongs here at all. User requested PMD
> > split and it is done after split_huge_pmd(). The rest can be handled by
> > the caller as needed.
> 
> I put this part here because split_huge_pmd() for file-backed THP is
> not really done after split_huge_pmd(). And I would like it done before
> calling follow_page_pte() below. Maybe we can still do them here, just 
> for file-backed THPs?
> 
> If we would move it, shall we move to callers of follow_page_mask()? 
> In that case, we will probably end up with similar code in two places:
> __get_user_pages() and follow_page(). 
> 
> Did I get this right?

Would it be enough to replace pte_offset_map_lock() in follow_page_pte()
with pte_alloc_map_lock()?

This will leave bunch not populated PTE entries, but it is fine: they will
be populated on the next access to them.

-- 
 Kirill A. Shutemov

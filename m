Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22C6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEDE206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="w9LAj5XF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfFMP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:27:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35143 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfFMLjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:39:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so26709139edr.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2xaaGMG7No2zQ7VPLAPzQ32rj+gGmBMPzXcN5RQJnF8=;
        b=w9LAj5XFY3ophQ4DwkbtNeEFNYTxLX2X5OdCVXnqnO3uj/VWYQ7iJfD888INwOAkyj
         0BB3q5T5bJea3946DH84lSLMeNeqV0RqrMsWryk4vyz07gNhLZ+xO9Gc7Ya9acqsvQir
         lmxxyDCm2sg4r6cj1gW51A9ku4YV1DJPROEeyiN7XoD00wvUn8tVxatQYIBRJyhGxPax
         hBSqiTLMnE9fXLPEcQ0rgzrh19vAcRiiEGtHraSy7nma6MHE2ewccw10WPd+GrVUCwmJ
         Rb60/5vDUddTfedPvHIZZE7qDEx2Xns7fcz97/+iv2Y+hSKU0gSZCCB9kVsDwnRlOfJ1
         ogRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2xaaGMG7No2zQ7VPLAPzQ32rj+gGmBMPzXcN5RQJnF8=;
        b=pII3OaJLYlChY+N13Bh4sucmPNU6op4zyIEhl3gKXQr44wWhKk0BxS6qzR3ZY2tm+J
         5EI6LyAnBx7CKm0MwCqMDXVyfnEzCpixBJ1u+s+Z4UFyuLrgndi5Q+F7WCuxeL4VXbAF
         VHqKBgRQInepfWKe+05RmfFA9MotX9A9YRhPtoOmS35U0oeD+PhSrCJbQpCD47YZiuWM
         ZpspqfUH0dlh39+fK122rC0UZIPl2azJkT6pw2mqbygyACQeAfmzZHUWampGi3Mc6izv
         3cTC+ixe7eBs+NFwKavQsc2b+W51AvlK9l/gJ8H1vdZox3eCUmAewVCovqUlzTsapSpG
         vx1A==
X-Gm-Message-State: APjAAAU+juSux4o+I/cpTncIc8aGqUrszVMA4NrWG6YJTk3aS0qbwsNy
        idp/jBvvGVCQkKzkF70tbEwtRQ==
X-Google-Smtp-Source: APXvYqy7Xsp8FQwiuXe2lfvRN1vozauF321WOLdOmtipAcKk82HAFQY/JTpoxC5Z6nYOM32/iIsHSA==
X-Received: by 2002:a17:906:308b:: with SMTP id 11mr15873396ejv.39.1560425985036;
        Thu, 13 Jun 2019 04:39:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d12sm841728edp.16.2019.06.13.04.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 04:39:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9479410087F; Thu, 13 Jun 2019 14:39:43 +0300 (+03)
Date:   Thu, 13 Jun 2019 14:39:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/4] mm: move mem_cgroup_uncharge out of
 __page_cache_release()
Message-ID: <20190613113943.ahmqpezemdbwgyax@box>
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560376609-113689-3-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560376609-113689-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:56:47AM +0800, Yang Shi wrote:
> The later patch would make THP deferred split shrinker memcg aware, but
> it needs page->mem_cgroup information in THP destructor, which is called
> after mem_cgroup_uncharge() now.
> 
> So, move mem_cgroup_uncharge() from __page_cache_release() to compound
> page destructor, which is called by both THP and other compound pages
> except HugeTLB.  And call it in __put_single_page() for single order
> page.


If I read the patch correctly, it will change behaviour for pages with
NULL_COMPOUND_DTOR. Have you considered it? Are you sure it will not break
anything?

-- 
 Kirill A. Shutemov

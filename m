Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A06C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1260820879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zDzjKRXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfENNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:16:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37563 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:16:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so22853500edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MTM1aBzPfSK5tgU1k2RNG5j9nKyYFdiQfhSRyC1AQNs=;
        b=zDzjKRXBJHz2yPiLvfNwWdJqq/vB0SaFrHEGC+4tdjK7qgnCrVKdrQGXbzYdw14oyQ
         2FN8i/6zGtMT7lmFJlnRkAQy9xn0Tp8jrpcCjZpMztqBnpJhbPLgLKtBXA5z8CinroXQ
         oUFY0Wc1G6z6gMD8EtLGHoj+izORshYJT61j0WN+f7ynFTnhvncUf8umGzpqVB3Cm+Uo
         tVXzXMPSSLzGbhwbKsIi1DOaLf+pAZVzIsTMvypZUewODOBy3mGMSnUKEn+UfHghHFyo
         n02Y3xxyaGokkB8Wh+M10bEQkurf0e5pdpzJBL1swKYPqDuk23hNfPs5vXLP7F6ulYgp
         ZoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MTM1aBzPfSK5tgU1k2RNG5j9nKyYFdiQfhSRyC1AQNs=;
        b=pZ+9ApUc2n4xgwRMvJhkEBe7UL1tCwCQkI8PWN8EZ69gTzzm6zCUfN4sl3woFk9QIp
         06zvAQewhu87qcc4oLETfW/FWdUs+YmvJrB9s86P4l5S+XRoyl5FpNeRgn0MMlwEOdAi
         Ixh0vC7jy+FdDlVbhFFbqUkAr9mKCbHSPjh5H0ktMwWGK0jTfulzqMj+UmbjMXWE9+KF
         086IqHSjEbSDnbWFUq+Hl5lJID6fsBCFpCGWnSSurFLeatjz8lRtgpu+5vH/Xe57URna
         9vTcJoBV3JRKBkQ0FcYSWVQONObZgQs9FhtbIgUESepfgeUmx/FVQHO+9xfA0LoS4uih
         rHMg==
X-Gm-Message-State: APjAAAXKhOEyVaGGqQzkW9t0zKdKxlX0IV/6IbbXy95X6i6Cd0UYveAr
        lQBANBMUs+V39p6z1sEIRAV/yw==
X-Google-Smtp-Source: APXvYqxcAIh9/gohpAQTlGcytkwF0FDILsHXqj2wEvoP1yEMfI5z16TGN2EPlhSbHRGWJA81mLADdw==
X-Received: by 2002:a17:906:74a:: with SMTP id z10mr15167062ejb.199.1557839814937;
        Tue, 14 May 2019 06:16:54 -0700 (PDT)
Received: from box.localdomain (mm-137-212-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.212.137])
        by smtp.gmail.com with ESMTPSA id h8sm678784ejf.73.2019.05.14.06.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:16:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F1D16100C33; Tue, 14 May 2019 15:28:20 +0300 (+03)
Date:   Tue, 14 May 2019 15:28:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     mike.kravetz@oracle.com, willy@infradead.org,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH, RFC 0/2] Share PMDs for FS/DAX on x86
Message-ID: <20190514122820.26zddpb27uxgrwzp@box>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 09:05:31AM -0700, Larry Bassel wrote:
> This patchset implements sharing of page table entries pointing
> to 2MiB pages (PMDs) for FS/DAX on x86.

-EPARSE.

How do you share entries? Entries do not take any space, page tables that
cointain these entries do.

Have you checked if the patch makes memory consumption any better. I have
doubts in it.

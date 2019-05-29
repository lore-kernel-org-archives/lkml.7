Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F03C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0121019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pvzGmqfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfE2MsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:48:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35032 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2MsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:48:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so3641564edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MONbMDhNRBTOrhsT93yPHwMAxRk5gJkctOPhsHPlMjo=;
        b=pvzGmqfndke61sBQlh1oho21KJ6Iybo1zHRk74CTMX5dILmjLpgpFD9xiNkJcIkykj
         88K6WVvQaUnOZAxTaXUwsfom9gc9tKGhAlt9jDh1AvRVL2fcPUPvVciXyd+4/cfnzi6Y
         BQc+Kf6NRRPU+LUsTWAkOih+0iPrKPi5AV8QW2IPC15kto3MI2CcTIDgyW1NvpvnbaHn
         72gRT4fZtCzDKYazAwoauPiUnTinRIP0Jz8q0vmBhjkSQvKq344X6obRR8SDoPT0HYGL
         IzumjrtY2Gd+o3l7MaUv/iBxsDD93S/NUHjHNBVVcbESUuNn/24MBGAgjnldGThCL3xB
         SLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MONbMDhNRBTOrhsT93yPHwMAxRk5gJkctOPhsHPlMjo=;
        b=cJgZou9ZreNowmy8OlAWpcnI3BdhOvoxCZcpPgE2cd8NNf207XU/kGtK7hrRTU6n2/
         XLr0PgzarjCINiVRTGaqCDp6sGY5A2JgxPm49hZzcmi2gWgcqi66HACtPagr7mVp6pAL
         sHH+gLDLgINo8EbPfufmXMKxaHJVyZdSKqrUUHH7ofHWCSj+nbGkpXzSPeGS71/Akj+C
         dGKrFjLK2auwY5NoY5kr5QXhZSuybYlDYwteKpo2SqursDXzsOpdjhs6+g9GX8TTM84T
         0uSxcAH0Wm6fhmKWV1XiJyjOfgnS+buhxf/2SmXKw+YFuDhcMrDxuJRcarDUok2Qe1Jc
         UFHA==
X-Gm-Message-State: APjAAAXjO2G9SDVouzyw1ZftL/UARn8bn7E7aMToB3jgBSKribDgYDwY
        /sAkO7YcJI212s5UNZU0clRtuw==
X-Google-Smtp-Source: APXvYqzoaFmZ7mZVbDTqlrFuJBSNrSbiSO0d9+zexx5kswJ+G5IjO7KLQ5NjC4EQdadEnFovCFgWeA==
X-Received: by 2002:a50:86e5:: with SMTP id 34mr136814479edu.290.1559134080713;
        Wed, 29 May 2019 05:48:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id qq13sm2797939ejb.1.2019.05.29.05.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 05:47:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 050E01041E8; Wed, 29 May 2019 15:47:59 +0300 (+03)
Date:   Wed, 29 May 2019 15:47:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC 05/62] mm/page_alloc: Handle allocation for
 encrypted memory
Message-ID: <20190529124758.ojyakxdx2zf6nmtt@box>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
 <20190508144422.13171-6-kirill.shutemov@linux.intel.com>
 <20190529072124.GC3656@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529072124.GC3656@rapoport-lnx>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:21:25AM +0300, Mike Rapoport wrote:
> Shouldn't it be EXPORT_SYMBOL?

We don't have callers outside core-mm at the moment.

I'll add kerneldoc in the next submission.

-- 
 Kirill A. Shutemov

Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ADC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1930D20896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MTtnxOj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406579AbfFLCHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:07:52 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41790 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404880AbfFLCHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:07:51 -0400
Received: by mail-ed1-f53.google.com with SMTP id p15so23055997eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 19:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3TEzE60VRj/MS8YEEehOOQckYotYtM00jSjKCi8/jI=;
        b=MTtnxOj8b/+TTYuM6NNkobIsRNOElKsc/8BqXi3Y/+dNGP7+MZ2IGVtBb9IvQn+OsO
         vW74urYy7EzW8nl+nFudq/JabGlvyX3vo/5Hnrim+qNbyvWWoh95wiXSZNopPL+oXF/O
         eD2Pnlv4mFpK9NfsXHt421c7OE1+1LjF2t546fw5c+ALo6qKpb5Up3nS2VgDyXsEYmXu
         0EFS1eXIH10mQztjtBB9u+208ddm8dhgPx+iDuc40U2BU6O0uLBWML0c78uHFi1gvuAk
         cpkYbNvZV5mNIS/64Z1tTp9WdsscxLL6ysWN85wbls6CM1baoMoKiseSgh4yK5TDDiHE
         ByZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3TEzE60VRj/MS8YEEehOOQckYotYtM00jSjKCi8/jI=;
        b=Va40DPM1MtgQKNm72Ti0VdMU3RieGVeBCTPdcw4W9TwtANH3AbuwzVT8VxYg10s1Sn
         QZHSXClrQyWIn6KsL/pJMNOncwm1p7L0Y9TnL65NTEkwQcNkS/m1oQDuxV0JIXt4nEKQ
         WvspL2IjYXt92ChVTZGOq46N/9WTwcoGtKJRyV2DX6FkdJjqbtSHuMt7WK5qqWWFFvR3
         kJOUnpdouo9suCuqKRgJOCeMv2PDGuTX7wVpWwcFN61nDaVsz6pTkc1yOjxxDUHXWzmP
         gCTMegKZQKhxk/j070vjSae6uGwDhlPnCyr5+30MQnxXh1byCD7n08/lRIDQvefuhDvg
         Ra7A==
X-Gm-Message-State: APjAAAVQ06z+gKQpDCWYKaHHLdaKrIM9QuJO6uoglDrWbQH1T341POZR
        FJ6AbWsRyfwXHi7jJYr1DD6jIw==
X-Google-Smtp-Source: APXvYqz0F/coC3G7qHRNAuBkWxFLoYTo3WBL7aSNleJKw+ls654OvYPBn0myZDv5kyjEpbjibAS9FA==
X-Received: by 2002:a17:906:7d4e:: with SMTP id l14mr19826791ejp.188.1560305270074;
        Tue, 11 Jun 2019 19:07:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v18sm3176634edq.80.2019.06.11.19.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:07:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id ECA1F10081B; Wed, 12 Jun 2019 05:07:49 +0300 (+03)
Date:   Wed, 12 Jun 2019 05:07:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     mike.kravetz@oracle.com, willy@infradead.org,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH, RFC 2/2] Implement sharing/unsharing of PMDs for FS/DAX
Message-ID: <20190612020749.sjpuquzxrprkalfy@box>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-3-git-send-email-larry.bassel@oracle.com>
 <20190514130147.2pk2xx32aiomm57b@box>
 <20190524160711.GF19025@ubuette>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524160711.GF19025@ubuette>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:07:11AM -0700, Larry Bassel wrote:
> Again, I don't think this can happen in DAX. The only sharing allowed
> is for FS/DAX/2MiB pagesize.

Hm. I still don't follow. How do you guarantee that DAX actually allocated
continues space for the file on backing storage and you can map it with
PMD page? I believe you don't have such guarantee.


-- 
 Kirill A. Shutemov

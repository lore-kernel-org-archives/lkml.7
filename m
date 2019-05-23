Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB2C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B50217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgCePIf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfEWSGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:06:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbfEWSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:06:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so7245640wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aD4OTx4SNkcHeIl9DAY7zYZfZaSA4B9rjGU3TeuTjX0=;
        b=QgCePIf0RmeNYyKTcnnGF9ryJs0rLJLMfHofq3c3S0g1s5RSeyrb42gt7BecSGVdNi
         HeWZVUh5zZa/xDEAJZ44Pst6V5Dyzd5JOTVOEYMDln3kYPZtwdPWG/ErrOATN3Km3l3n
         zQYbO0zoL66RFTuMr7yDqCwHOFlg0P+GWgvLj+BaKqdVBF79VLYcPC8OyAxINee8EBcY
         IfukgJj9+rBLsE+Z0dYhBc27xsHt5XuGfTZzcaeuNgZhAFLubTvhEFfv3Rk51qzG0ULl
         RJgh+0Zi0XCsDLUIPStQOhRuX71uxJGpJGSUD+zvpEivCPdwtJ549cZZ/VNowj1hQOFw
         HUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aD4OTx4SNkcHeIl9DAY7zYZfZaSA4B9rjGU3TeuTjX0=;
        b=AKUOfat7iKqT7kzQhidZ22vniWk2C6Jkms5UQaqmi8tSoB+MHsn+YblieXRWfWWd4g
         UGnZraVyHSBS6uoiHhG1wY6ChxlkgabQnS3eh3fYUDaGGRtsuy8KvWhq03I395Iy6S4r
         mEg3TJpGVH2+QXVGHj3AoKkKnaeVEP22/P6J9SVPqsJ86gjtD/1+SeM/JwW0oSMuUaQ+
         5qsE0O4ETCEXTa5LvUnfUU+KgPXgC9IMOwzVTtV//dQCNHo+6iHgIHZ3jbZScfglOagt
         c3M0k/cXeW9LuJizgcS6CbJfsi5ijfN5JMfAxkLVf5UbGgKPKkpBRcxhVsQidebY/VSI
         KItg==
X-Gm-Message-State: APjAAAXyWxPyTAMfipVFxlvE7bmG99Tx4B23yOzJf2VcETCAAK0zrXjS
        veD8+5brAaUuTTLfbC26wygFT64=
X-Google-Smtp-Source: APXvYqyE4HWsJw9Gl5a5UqZDhUfIdxoOIm5ES1rK2roNoaimvPoUojr7V8vDxj4SMuryrGwVTLE4vQ==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr14740944wru.183.1558634759668;
        Thu, 23 May 2019 11:05:59 -0700 (PDT)
Received: from avx2 ([46.53.252.55])
        by smtp.gmail.com with ESMTPSA id z20sm422279wmf.14.2019.05.23.11.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:05:58 -0700 (PDT)
Date:   Thu, 23 May 2019 21:05:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     noring@nocrew.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sscanf: Fix integer overflow with sscanf field width
Message-ID: <20190523180556.GA6430@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What are your thoughts?

Don't use sscanf(3), it is misdesigned.

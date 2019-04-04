Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C55C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E15E206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyR91XKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfDDRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:24:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfDDRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:24:34 -0400
Received: by mail-io1-f67.google.com with SMTP id f6so2703836iop.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkdUEkcxFkzk6/8LedbuZeBMeRGDZcjzLzb6vhWuFOE=;
        b=dyR91XKloyyp+E859Ey8oSsuOa0peX78frffGQaDEBpqPLgjGPCUZkwof2Inry+5fk
         6EIa0s7GuXpgNwp1ORheRePXR0WrAp2zkiOk80sAplV3ToyNV/5Tob8UI6qtFylPR62u
         bb6L6D8/ifc29N9T3XPlVtogOzBmbOlzoCwtnu0/WdwbkJSygax5RACm+L7n1hudLz6B
         3/9avlC+aZS5c09xexGUuXb4c3pjN4n1LEda6KKhM4DrW7MftH+u44Hd2t4hUJeCUfnL
         OpOChi3xSgbU9BDXe9PCDNYrrZc7LH/gEecV5w9QNZ83VC0pwa8YZkrx1v1W1D5o5TND
         DWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkdUEkcxFkzk6/8LedbuZeBMeRGDZcjzLzb6vhWuFOE=;
        b=gSVJAk4t2/pkAPqCN6kK796h/eefO6KHXtAhSLH6s4qq5deua40+0e8saT0XGFXQ3a
         2iHwknJBTPWiTsHlrHVkIGuZGr9qxK8Oc9w98eI6g+lHF3GaCuV6dHyudBPBE28z0SFo
         09Z4Bb0FQwnh2kHtMyNip6obXxE4hy8P3Y5rmhxfx48OMztPYbzf979u8oKKobzrmDdv
         5oT4gAcC/Xf8FdL6EavMQloUUI8UC5ZS9oIJwo5vUAv3tdX45OomoVYsszKQ2dvtQ1ee
         kG2IxB/ag9X7TOvfSLhenWLiZcW8gIuaTTHaZ9izfS5w4w0OibolnOqimS0nSH0PVc0H
         eqpA==
X-Gm-Message-State: APjAAAWFutAwp2nY++exL9HzhfGJSS+0vvqwAR+rBmQ5kPykj+xFffpF
        fxvV4P8o+SMot4MsCLN+C+eYSdFxSKVYSF+ysYsv8g==
X-Google-Smtp-Source: APXvYqztxdGonMa4pstJ/7vRubkc7YZsFytjtWtE0y/NyV5nZ2xpD80rsAtV3lZX5D4GvPVD7zAGkqrNa7i8yFftSj8=
X-Received: by 2002:a6b:691a:: with SMTP id e26mr4984716ioc.124.1554398672881;
 Thu, 04 Apr 2019 10:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190402215556.257406-1-matthewgarrett@google.com> <20190404124057.GC14738@linux.intel.com>
In-Reply-To: <20190404124057.GC14738@linux.intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 4 Apr 2019 10:24:21 -0700
Message-ID: <CACdnJusEua0nyF2xhSVbFKnUxNVPT01e65yJs8cROMMO-nT6QQ@mail.gmail.com>
Subject: Re: [PATCH] TCG2 log support build fixes for non-x86_64
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 5:41 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Apr 02, 2019 at 02:55:54PM -0700, Matthew Garrett wrote:
> > Couple of patches to fix ktest reported issues with the crypto-agile log
> > format support.
>
> I guess I squash these to your earlier commits?

Works for me.

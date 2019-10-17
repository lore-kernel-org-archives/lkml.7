Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A2ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5EB20663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="etL/U/YU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409041AbfJQL12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:27:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34842 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405872AbfJQL11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:27:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so2160458lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u27O11IXpE4QvzJ/zXnS9tRoa9paocA4KgwexhvBV0A=;
        b=etL/U/YUGzssW4XgyN4D34Kd6ceXI5McsWW1RMa8MzO0QVp315FdEoKzbfZO23zUE1
         RtM4VFBSm1kJ2nyanIMyGUYcLMxKeryAxkGU125tY9H6Pv9ScpZ4JETL1haWnelhenFP
         37o7c+Pb2PUjH5v4WNvZn1rvbQBv1r7e85naEyjRq0k9bIDxORHI3kEqhTcIipMj9aeF
         0nckySMYQs37OaNh7T3RWcZ0a2qn3CNerYAgWW9FYuwwmIgXIyxC4AAe5XbuzHzM4UtM
         0g+dn6cLoXAUjTqCcspUkSQwybPp9l+U5RZk5A6Sts2kOYJ/xYctqJfqFrhVXCEJoX1F
         8iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u27O11IXpE4QvzJ/zXnS9tRoa9paocA4KgwexhvBV0A=;
        b=IP3ssWd2SZQOGwyunK0rY9toPkYexzaQkiIrybVYHo5cJa4sNsZATWkCgoxPu3sfs9
         X3JgOOK6c1zSz75t19aFK7PqlIMm1rneLkzxBw8cn93Ywk/ud7gsdZPukKuOsFWdB4YY
         vyvu9HhodVVgHsSHuy/GYplIG/8hsLfPCOPx+LixYoK/xaSX5M9/+wmMhRKNxgQ7rIcU
         6+qUFYVCLcuxi6dHP7Oi3W/geqpnskkae8+Yn3QOEVVZrDbhF5II+6IZTX7gtfY0P34b
         CSs4usKHWpsT7ou2H7JPdHpRnkcXJSsczJffSbUmaBUijJabiSvTwMYwRrZZ+pjYvS1w
         t5KQ==
X-Gm-Message-State: APjAAAWS5nEMhbiHrrntc8Rrc7JfzI5hr1W0Jm2xWdBP8Nk2uCuwuwAf
        V+mAJzqPnS4s/bGgM+3JvK+pmw==
X-Google-Smtp-Source: APXvYqx4QY/DUy+spdzmA2DFZYHvqz6zJNE6ZDiq/1MRsKG1tmvmCLaALR6USc4RJjFTmU7YV4CkjA==
X-Received: by 2002:a2e:b4a8:: with SMTP id q8mr2152296ljm.106.1571311645987;
        Thu, 17 Oct 2019 04:27:25 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q24sm1165212lfa.94.2019.10.17.04.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:27:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 456311001A2; Thu, 17 Oct 2019 14:27:24 +0300 (+03)
Date:   Thu, 17 Oct 2019 14:27:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, keith.busch@intel.com
Subject: Re: [PATCH 2/4] mm/migrate: Defer allocating new page until needed
Message-ID: <20191017112724.f74v2xqgb6swo7w7@box>
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
 <20191016221151.854D5735@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016221151.854D5735@viggo.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:11:51PM -0700, Dave Hansen wrote:
> 
> From: Keith Busch <keith.busch@intel.com>
> 
> Migrating pages had been allocating the new page before it was actually
> needed. Subsequent operations may still fail, which would have to handle
> cleaning up the newly allocated page when it was never used.
> 
> Defer allocating the page until we are actually ready to make use of
> it, after locking the original page. This simplifies error handling,
> but should not have any functional change in behavior. This is just
> refactoring page migration so the main part can more easily be reused
> by other code.

Well, the functional change I see is that now we allocate a new page under
page lock of old page.

It *should* be fine, but it has to be call out in the commit message.

-- 
 Kirill A. Shutemov

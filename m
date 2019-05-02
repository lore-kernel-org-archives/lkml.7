Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6463FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE62087F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlSUJ7/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEBVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:10:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44671 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:10:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id n134so1134595lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tcMOLF2Npln0wz4ssEpXXJP5i/zIoQ58cnAHA6z5aF0=;
        b=FlSUJ7/piDYFhxvCgI0Gt4KnW4fnyXCozKS4bJVx96EUwoY0MZMrAW2YzwOqdIHivo
         GMAcHUpu+MrTppPzdzUlzMLssEIuv186RlYmshd6nhkX30kC24z/8NMJGqD/DVd/TzwE
         h9Pl7y5nNn2FPDIOM3D0ijgs5SXCsMWMoFHTERCVfyxHf2qr+FRnx7wpbrCBBfynM1KH
         AVWDZ+2vYFW9Srt2w3HZ1CZboOJyrtlR7zrZr/7z7YFxv/lJm7fEbEK4l8d1j4dzGBDP
         I+WVDVL7abhklp6lQagcdCu4kW5jedt/CTXWDRDmZTBLVvXTlBFnJ/2b5R1PTfQeQ+HR
         ODHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcMOLF2Npln0wz4ssEpXXJP5i/zIoQ58cnAHA6z5aF0=;
        b=b62aYqFf+4RlRA263dAmTwXV1qkd9wBtvEfIB6kWxWFuKqiWfkqJLjrYaA9cdF+gE6
         WiLhw3sch2NH3cE8RP3xIVgM1bN+KgM11EEY9O3Jf0ViercRg3Vhw/xy+Sa9W0bI0GOM
         XcFYbnhVWKmCF4YLzRVxxlWXzfC5cf7PWTDynSpImgiNb1skwKbMAI4LEgGRhOjKul3P
         xyvETCQEFCvG0cwZ8gBwzUUzXBInHxRvc89iFWJvpAB8ah3xmHFLhv3P3rVzWjk8tRBe
         EdLKJtZtqNaMJs6rzKdTQrYaZ4oJ16Vm1XBVq627IR96HDb3Sct804Bra/EGkgDcpjWn
         2yjQ==
X-Gm-Message-State: APjAAAXPP/Gr7z/4OZBWBTf1/lSCFWHd1TKECyVEw4F0fgjXQ2XbHvrH
        le4FvSWw+wZjSvP9M1AWjz0=
X-Google-Smtp-Source: APXvYqw8Ghmz1lkWfXNcRpu7G+pfnoHq6Ocam2APpRN5a/nkeh9y8/7k71k5HmQ69t1P6/RbkHWzew==
X-Received: by 2002:a19:4acf:: with SMTP id x198mr3125176lfa.7.1556831403244;
        Thu, 02 May 2019 14:10:03 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id k10sm15730ljh.86.2019.05.02.14.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 14:10:02 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 18D194603CA; Fri,  3 May 2019 00:10:02 +0300 (MSK)
Date:   Fri, 3 May 2019 00:10:02 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <norov.maillist@gmail.com>
Subject: Re: [PATCH v2 0/2] sys/prctl: expose TASK_SIZE value to userspace
Message-ID: <20190502211002.GG2488@uranus.lan>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <8bb9fe29-65d3-e977-1932-4a2f17ead333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb9fe29-65d3-e977-1932-4a2f17ead333@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 05:01:38PM -0400, Waiman Long wrote:
> 
> What did you change in v2 versus v1?

Seems unsigned long long has been changed to unsigned long.

Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAEAC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9921920656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfHOOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:50:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48246 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbfHOOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:50:49 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hyH5T-0008TD-W7
        for linux-kernel@vger.kernel.org; Thu, 15 Aug 2019 14:50:48 +0000
Received: by mail-ot1-f72.google.com with SMTP id k22so2379959otn.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNivIfUkkplVV5pp6FTdEbZdfJdI5yapbUq276+kheo=;
        b=pbsrktOoTsbkil77F7zXXhrbfnkZDlTsVV25iwUD7Yw9HCnvCByMbOPmrGBFAQDVEx
         nA2nN2zXyDJDD7s+1vs3g6c4H7w4fzVMlJQunhK5EdQ/GnxQF/vQeEmWev4z5C8gWqNh
         tcavCSJqykn9NzSxqJHF83QvwzEGY6c2BjDIYkHkNvXEZddyNB4HrwqdIstRYasAhhbL
         qIr7rDaTL/P153TB+5+aaYtL2v5mA7SaJLW9ncI3wGukZYOckquEEZmJqN3cTvojKbCf
         t5JlwxfmfMb6Xi2nGYnZYVn0SVUpqAo/745bhOdjFKndWMGazNXypiRgT0SQ/63eNUEX
         Bhww==
X-Gm-Message-State: APjAAAX6TrJCiHC69wrdn/rH4wX6x7JE7qJSsFxa9wl8u6YwnPixVaCT
        WIxvg0dYolKPQvodf8yBUIdwKt5eizRfUgKVBPMl5J1ksa2NWkOyX9xncWGGDo4U4BkvfK+bvtk
        /yi1oi7JfEihP2oVPj4k/NnG7UbCmroC/rOVrMclA0A==
X-Received: by 2002:a6b:8b47:: with SMTP id n68mr5665456iod.191.1565880646901;
        Thu, 15 Aug 2019 07:50:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcSUVoo5IYuezAtpbdOKSul/TTMZm3PFMuJPW0LxqdLEZKI7wZF2mkZZgZLypI7dFN39oqFA==
X-Received: by 2002:a6b:8b47:: with SMTP id n68mr5665427iod.191.1565880646626;
        Thu, 15 Aug 2019 07:50:46 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:443b:aa6:53cb:2ee7])
        by smtp.gmail.com with ESMTPSA id r5sm2054854iom.42.2019.08.15.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:50:46 -0700 (PDT)
Date:   Thu, 15 Aug 2019 09:50:45 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Stefan Bader <stefan.bader@canonical.com>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Brad Figg <brad.figg@canonical.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/1] Small potential fix for shiftfs
Message-ID: <20190815145045.GY10402@ubuntu-xps13>
References: <20190815143603.17127-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815143603.17127-1-oleksandr@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 04:36:02PM +0200, Oleksandr Natalenko wrote:
> Hey, people.
> 
> I was lurking at shiftfs just out of curiosity and managed to bump into
> a compiler warning that is (as I suppose) easily fixed by the subsequent
> patch.
> 
> Feel free to drag this into your Ubuntu tree if needed. I haven't played
> with it yet, just compiling (because I'm looking for something that is
> bindfs but in-kernel) :).

Thanks for the patch. Christian has actually already sent a patch for
this along with another patch which is still under review:

https://lists.ubuntu.com/archives/kernel-team/2019-July/102449.html

Also note that currently shiftfs is only in Ubuntu distro kernels, and
Ubuntu-specific kernel patches should be directed at
kernel-team@lists.ubuntu.com rather than lkml. If you'll be at LPC,
there's a session to discuss the future of upstreaming shiftfs that you
might find interesting.

Thanks!
Seth

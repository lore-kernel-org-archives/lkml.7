Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F378C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D4F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDZO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:58:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40547 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDZO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:58:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id s4so1858476pfh.7;
        Fri, 26 Apr 2019 07:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMQh9XBillKy5krF6qsSUFgQCwi9BwCLnIQeFWNI9Gk=;
        b=gdGLTgO8E4X2iuO2wndMVoIEm62M18XzKnO7W51fJtPYCiJXaJBaBUD46Yjt4NNV9W
         ZR7HIkGijLmq7pU495nvV+rl+UufWodvyQog02oKLK2BywvZo4jGQnr+JHlAVhy5m+fJ
         i07cM+hTuRjHwzM21/wGNXT75l3dMsWM7+tHSngDjYDZLJONpjJIOqK07wAm3L11Te6n
         GXRr8JiBZ1H9LI8EMCzMMQYLrAGVfVXNW0jS5a/wkIqYWTpx+oa61xJiN87dijPYLUJ3
         w5bUdIJVT901MhA0Un8r5z9pRWbnf31bW6+ARTrgF4nGNL3vp1rb9kZSmqU4zZwTyFPA
         iPew==
X-Gm-Message-State: APjAAAXAOwAn9AJK4dAD/XIRnmWRhMK6JpjnveJE8fKzLV9qljYrFGaV
        5BUh5R8kK/t6+d0fvS7F/lI=
X-Google-Smtp-Source: APXvYqwOaLihjAx0xKZYtfmgyTigR4D69gmvv1YlGtU2GXNLZluroj9WZKi4o6oAknWhMCRpYkmmMg==
X-Received: by 2002:aa7:810e:: with SMTP id b14mr3611878pfi.112.1556290731623;
        Fri, 26 Apr 2019 07:58:51 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p6sm31782883pfd.122.2019.04.26.07.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:58:50 -0700 (PDT)
Message-ID: <1556290729.161891.148.camel@acm.org>
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems
 on Thinkpad X60
From:   Bart Van Assche <bvanassche@acm.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com,
        mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Date:   Fri, 26 Apr 2019 07:58:49 -0700
In-Reply-To: <20190426103249.GA5001@amd>
References: <20190423102239.GA15531@amd>
         <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
         <20190424095431.GA32457@amd> <20190424104850.GC32457@amd>
         <20190424202119.GA26357@amd> <20190424204832.GA3111@amd>
         <20190424205150.GA4582@amd> <1556139361.161891.140.camel@acm.org>
         <20190425073343.GA19600@amd> <360f6936-ee21-a036-9bd4-93ecfee829e2@acm.org>
         <20190426103249.GA5001@amd>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 12:32 +-0200, Pavel Machek wrote:
+AD4 +AFs-detached HEAD 916db0d+AF0 Revert +ACI-scsi: sd: Inline sd+AF8-probe+AF8-part2()+ACI
+AD4  1 file changed, 58 insertions(+-), 43 deletions(-)
+AD4  pavel+AEA-duo:/data/l/linux-next-32+ACQ git revert
+AD4  21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
+AD4  Editing file: /data/fast/l/linux-next-32/.git/COMMIT+AF8-EDITMSG
+AD4  1163
+AD4  ?
+AD4  +AFs-detached HEAD ac8d625+AF0 Revert +ACI-scsi: sd: Rely on the driver core for
+AD4  asynchronous probing+ACI
+AD4   4 files changed, 47 insertions(+-), 5 deletions(-)
+AD4 
+AD4 
+AD4 And reverting those two indeed fixes it:
+AD4 
+AD4 Checking version...
+AD4 version is  Linux amd 5.1.0-rc1autobisect1556274387+- +ACM-261 SMP Fri Apr
+AD4 26 12:27:12 CEST 2019 i686 GNU/Linux
+AD4 Running test...
+AD4 Result is +AFs TEST SUCCESS +AF0
+AD4 Test said TEST SUCCESS

Can you share your config file? I hope that will allow me to reproduce this
issue.

Thanks,

Bart.

Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3AA218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfDXWfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:35:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36885 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDXWfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:35:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so10116535pgc.4;
        Wed, 24 Apr 2019 15:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w28r0x/zBL707cFfGwPd+N8cqQQkJsnRMtyGogYxZ8w=;
        b=U4RmvXc6ij4Ji44toD6vYlbg42fLJ85cVyrSfWO4eXhYS0oRF9X27itJhUUDMi4I8i
         OMt6/YLZrHOgRMF2TlLbgfvsCwIY2wTxB6zFNY7gxgt7zA2c12Rir2VUy9ngWo0lQ4tv
         Wic9a77fBP1lU3wV9ibdV1cewN+BINv0XP8Mtg+kZMnMCSWE5PdOEQuitS17dqqzfuU1
         r6aUJ9fxNwC4aJBproeheNjxIwedDTO+Yy/EBSG8DGc2iv5jU917TN43SWqLb0wWIU6/
         igCnyrWjxoy+08khjy4yITb1k8SL1Q9h0IHhsk6dMyMwAFMm4q4VBE3KBoxehHu4LE9k
         gQdA==
X-Gm-Message-State: APjAAAXYWC3Yv1mAP5d4G147ZYa5feKcdTOexk1rH8iTyqT3u7dNFiD7
        6p1RZyU/ukpcRIybbGMRyxgEr8Ifc/4=
X-Google-Smtp-Source: APXvYqwnVRGDodqVeo5eJ0m5RF8yAPDOdwC3xPIXk6ms4szKaZwm6KdQHd7DCO7RZQlREI4xerTdbw==
X-Received: by 2002:a65:4482:: with SMTP id l2mr11054578pgq.362.1556145299259;
        Wed, 24 Apr 2019 15:34:59 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v19sm26824512pfn.62.2019.04.24.15.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 15:34:58 -0700 (PDT)
Message-ID: <1556145297.161891.143.camel@acm.org>
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
From:   Bart Van Assche <bvanassche@acm.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org
Date:   Wed, 24 Apr 2019 15:34:57 -0700
In-Reply-To: <20190424101711.GB32457@amd>
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
         <20190423102239.GA15531@amd> <fed0549d-a789-294c-d899-304911106113@acm.org>
         <20190424101711.GB32457@amd>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-24 at 12:17 +-0200, Pavel Machek wrote:
+AD4 On Tue 2019-04-23 07:09:42, Bart Van Assche wrote:
+AD4 +AD4 On 4/23/19 3:22 AM, Pavel Machek wrote:
+AD4 +AD4 +AD4 +AD4 +AD4 It boots ok (unlike mainline -- I'm debugging that), and I can suspend
+AD4 +AD4 +AD4 +AD4 +AD4 and resume... but then cursor in X is moving and I can talk to
+AD4 +AD4 +AD4 +AD4 +AD4 applications cached in memory, but any access to disk hangs.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Mainline problem was identified.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 But resume is still broken. I took advantage of fact that I can still
+AD4 +AD4 +AD4 +AD4 do cached commands, and got complete dmesg. I'm attaching it.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Still broken in 0418. Ideas would be welcome at this point.
+AD4 +AD4 
+AD4 +AD4 Have you already tried the debugging steps explained in
+AD4 +AD4 Documentation/power to obtain more information about the nature of the
+AD4 +AD4 suspend/resume problem?
+AD4 
+AD4 That won't help, as system resumes ok, then disk hangs.
+AD4 
+AD4 Does it work for you?

Both +ACI-systemctl hibernate+ACI and +ACI-systemctl suspend+ACI work perfectly with the
next-20190424 kernel on my laptop (a Dell Precision laptop).

Bart.

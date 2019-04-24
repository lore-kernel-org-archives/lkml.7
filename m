Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9D6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895D2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfDXU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:56:05 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:33347 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbfDXU4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:56:04 -0400
Received: by mail-pl1-f182.google.com with SMTP id t16so9910997plo.0;
        Wed, 24 Apr 2019 13:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QShtnSBBdl9aNMz7NhCO2l2l/BCiMAzjFl3S5ZIFE74=;
        b=qrZAvviKh8xsCatEkuI1gaNUeIGC/t4AcxvlZ84wV7CPI58i3ffMPQ9On7xJhvsYpr
         cnU60Bz1vOxZ8vX4QXrf72xu2fC8iEp3MMho3SyI72np4an1wAgBS4OgMlElN8oxqlCF
         j0tLVrIqcKGf2Qpc8KIKasGdliuijxFC29q3dCRKXFGufKa5/6CZvt+SwV+hmpa/E4nd
         d5/0lwskgSrKYH5umGqvr5EeDnFrflbhNlE5HFfX+rC8Pu1Kw+rAqOx4KzDFcy6R1kqr
         1HhKKxWmQB+h7Aeugauyn4Sted3z6Bf4oeTHTURscHJv8Ew+VwdnFi+biIH79lLexb2m
         z+dA==
X-Gm-Message-State: APjAAAUSgykcDiCY8yRuNzFv9FFo1GSCN/8yUV1oHuNCksMWpXVElOk7
        sg2xLW9v5kAodpqQRcle0EY=
X-Google-Smtp-Source: APXvYqxRAGC1bEb3TJt/fa193BsKgmoBW0yf1bOw4sOyHDjDtmcwMPnHssBlqkscnXV/8gSOwq0DCw==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr35007368pla.306.1556139363717;
        Wed, 24 Apr 2019 13:56:03 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 6sm29614890pfp.143.2019.04.24.13.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 13:56:02 -0700 (PDT)
Message-ID: <1556139361.161891.140.camel@acm.org>
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems
 on Thinkpad X60
From:   Bart Van Assche <bvanassche@acm.org>
To:     Pavel Machek <pavel@denx.de>, Jens Axboe <axboe@kernel.dk>,
        jejb@linux.ibm.com, martin.petersen@oracle.com, lduncan@suse.com,
        hare@suse.com, mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Date:   Wed, 24 Apr 2019 13:56:01 -0700
In-Reply-To: <20190424205150.GA4582@amd>
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
         <20190423102239.GA15531@amd>
         <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
         <20190424095431.GA32457@amd> <20190424104850.GC32457@amd>
         <20190424202119.GA26357@amd> <20190424204832.GA3111@amd>
         <20190424205150.GA4582@amd>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-24 at 22:51 +-0200, Pavel Machek wrote:
+AD4 Unfortunately, that one does not revert cleanly on top of -next.

Can you try the following:

git revert d16ece577bf2cee7f94bab75a0d967bcb89dd2a7 +ACYAJg
  git revert 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3

I will see whether I can come up with a better way to analyze what is
going on. I had not expected that these patches would cause any suspend/
resume problems.

Bart.

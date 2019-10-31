Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB972CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D462080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKz6rJbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfJaXIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:08:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40313 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:08:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id y81so8818208qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5MX8NnY04jn4IL4Hhx3WYBLegDCE1aMGvKEiYn4imE=;
        b=kKz6rJbigiB4GVY5iBC13AAZczzZWoLpxPYDnOawsuWAgv9XgZzKlsRpKbIUQ+teCd
         BZvwSj4jt0UW3C/o7FoENV/LopnIMNbtHH8ojXHEKZCs2Z7IiHmJPmNoh9Shy3VaxOTW
         E0mm9mAYCjmnc5c7oG7yrfQko9peDGMzDgBGb8aAEMa8YifivexorE1socOTwbh+k7mH
         u39hk5PbHx4cb9SZqv3OypvuY+ARDJtAqpYOVlUchY1uAPkkwkRf+i7P31ieG5DbWQFw
         BO/FKUKkClUWEag9bkNOxulVLbkm455Vln6Wds7Fr0GoQ8EiMUO0T3N53LHIwUJIUsYE
         dydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5MX8NnY04jn4IL4Hhx3WYBLegDCE1aMGvKEiYn4imE=;
        b=odSG/SCfwZBRk/Bn7xnzo8IScMtR3VCQZgw+KkSXOOlK6tq70USebDJDnyIP7Fw3qy
         KTvz8itRM4nkk5GK3V1QPr7MBJxGnB8fYgB2R15CHCLm0kff3qIP8A029IJfd0yLL4hN
         HKngL1ikSkOQuwL5qzrqm6dxwUnu2iqY1kmU8Cr3PDQUBF8IZHFpI0Rq01fdxNOQP40L
         EI4vrcN3e5bN2hMeQUUJZY/SSaW66JpA2qI+1QAszdzhvTzyaOT4xiDpmWnMLd21TzC2
         IIEnvMgSDcu1OjSs+lbSHQR8xphElv6kRsySXsms1lqsE1IZiI4octsyk9g2G/PlTazR
         q78Q==
X-Gm-Message-State: APjAAAWYGlZ7emlDJNCqL9rqXih83NB489LLp0mqQnxNtmNhy4TibIXA
        Kn+cjP6DRj58ypJNu0JKhwPt4B/m/vs=
X-Google-Smtp-Source: APXvYqz1I2zayml7MofXfpt7vwo1D22VxS8xSVhmeM3EehlQ801FeRhRfoGsVPoOsX4xR2zvYEGCJg==
X-Received: by 2002:a05:620a:8c4:: with SMTP id z4mr2503208qkz.395.1572562977852;
        Thu, 31 Oct 2019 16:02:57 -0700 (PDT)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id s67sm2633875qkh.70.2019.10.31.16.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:02:56 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v4 0/3] staging: rts5208: Eliminate the use of Camel Case       
Date:   Thu, 31 Oct 2019 20:02:40 -0300
Message-Id: <20191031230243.3462-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in tree rts5208                           
                                                                                
Changes in v4:                                                                  
- Substitute constants in lower case to upper case                              
- Explain the reason of keeping a variable that is defined and it's not used    
                                                                                
Changes in v3:                                                                  
- Change the subject line of commits to make it more clear and informative      
                                                                                 
Changes in v2:                                                                  
- Place the changes on variable's names in the use and definition in the        
same commit                                                                     
                                                                                
I compile the kernel after each commit of the series to make sure it            
doesn't break the compilation.

Gabriela Bittencourt (3):
  staging: rts5208: Eliminate the use of Camel Case in files ms.{h,c}
  staging: rts5208: Eliminate the use of Camel Case in files xd.{h,c}
  staging: rts5208: Eliminate the use of Camel Case in file sd.h

 drivers/staging/rts5208/ms.c | 86 ++++++++++++++++++------------------
 drivers/staging/rts5208/ms.h | 70 ++++++++++++++---------------
 drivers/staging/rts5208/sd.h |  2 +-
 drivers/staging/rts5208/xd.c |  8 ++--
 drivers/staging/rts5208/xd.h |  6 +--
 5 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A47FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2572C25FC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fortuneproleads-com.20150623.gappssmtp.com header.i=@fortuneproleads-com.20150623.gappssmtp.com header.b="pwDPh8XV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE3Shm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:37:42 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:43708 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3Shl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:37:41 -0400
Received: by mail-pl1-f180.google.com with SMTP id gn7so2895637plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fortuneproleads-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language
         :disposition-notification-to;
        bh=iHgOO7wAVyp0W63tHKXS1MOmAH/SiT9nrVEE2zyJsZ0=;
        b=pwDPh8XV/gfEXumXNmnEYwnQtlGrLs3mmM0CPFtXDq97OfVVChVK7wEudloJbkxLNR
         c2c2WTbjGl2AVeGapeFkmkWtiyD4OLT5adBfLEqc1c/K+8crz81UvP+GO4a6T+ukXDZ+
         Vyfs5Tvliudi4bdu6MdbApfnZ2KXQV29gKaod/z4Eky8El5Emd0X6U4/ITkdJRlqGOv/
         ZfomsIwRHM4oMh4LSvloIlJWRob1b7HuYzci8QkcKLsNHw+LX6dii1ilrQcQF216F3be
         VcNaVij24plLyGI1vnccipKlw9gdPIIdtkkSVkoph6pJY+r5fk+W9EEImPmOCE7O3Z8x
         HV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language:disposition-notification-to;
        bh=iHgOO7wAVyp0W63tHKXS1MOmAH/SiT9nrVEE2zyJsZ0=;
        b=UY8Ax1P2CfCoL6f151WCKSwvPtDVjXRsS3p67erb6Ks+xKeGKeHkUFNmhJTNQhhJwc
         2eLmisQMGOwcW0Twp0ElslXWZ7P9+/5lCmNo2/5/uA4MeTQWWh2Dlx21wR1f5VbLbYRY
         YYuHif160F2soGqa7MXlyupMTNehUEQAycRLHz7gV622wDVUQZS316VuwjCJjqx+0GQq
         8ZTqOSmVeokG5V+yl1PHx2xvjh6h9Y0sYyBgJ1IngSnB4D/2zga4JF9OU7H3OZbcsED8
         mpAteUc8wDiRkokCJxNjENTLAvvg17Oceu2rExg8w11VoYrh8H8VG5j+3BgLLn8eOxIw
         JH2w==
X-Gm-Message-State: APjAAAVS+WIY/cMO52lo/W1VaTeKU2xQjN/gdEYoR+a3FhdKe6ni1RjP
        mALk4FSUNDptONvhJK/kuiUDxA1ndNQ=
X-Google-Smtp-Source: APXvYqy1QLra5JMoDqpTbcLskysjyj7rmukYrjPHOjMnG4oEr1hsXtMX0kuLCPsEokD3j4/+zr1XTw==
X-Received: by 2002:a17:902:e48d:: with SMTP id cj13mr5089716plb.156.1559241460677;
        Thu, 30 May 2019 11:37:40 -0700 (PDT)
Received: from adminPC ([27.7.15.150])
        by smtp.gmail.com with ESMTPSA id l43sm3592559pjb.7.2019.05.30.11.37.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 11:37:40 -0700 (PDT)
From:   Cynthia Higgins <cynthia.higgins@fortuneproleads.com>
X-Google-Original-From: "Cynthia Higgins" <Cynthia.Higgins@fortuneproleads.com>
To:     <linux-kernel@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: Attendees Data Base of IMS 2019
Date:   Thu, 30 May 2019 13:37:15 -0500
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAPLrA/fFBKxKlekVRQYDRGnCgAAAEAAAAOp5Cvg983ZMuPe2kBJpOWUBAAAAAA==@fortuneproleads.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdUSXlKMgtmIiwvARiu5ZTpveQo4VQAASirgAAAAFaAAAAAEQAAAAARwAAAABKAAAAAD0AAAAARAAAAABGAAAAADoAAAAAUAAAAAAzAAAAAEYAAAAATQAAAAAwAAAAAFYAAAAAOQAAAABSAAAAAEkAAAAEDQAAAAFGAAAAAE0AAAAAQwAAAABJAAAAAEAAAAAARgAAAABMAAAAAFIAAAAASQAAAABSAAAAAEkAAAAAQgAAAABYAAAAAE8AEtst5w
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I'm writing to thank you for your time and to find out how you'd like to
move on my previous email.

If you're still interested, please suggest a next step. 

I would highly appreciate if you would share your thoughts, so that we can
assist you best solution along with affordable cost.

I await your response
Cynthia 


_____________________________________________
From: Cynthia Higgins [mailto:Cynthia.Higgins@fortuneproleads.com] 
Sent: Friday, May 24, 2019 2:36 PM
To: 'linux-kernel@vger.kernel.org'
Subject: Attendees Data Base of IMS 2019


Hi,
I am following up to check if you are interested in acquiring IEEE MTT-S
International Microwave Symposium  Conference 2019
Let me know if you would like to acquire Attendees Data Base?

Attendees List:  Senior Managemen, Engineering Management, Engineers,
Industry Leaders, Government/Military And Many More...
Each record in the data base contains: - Contact Name, Job Title,
Company/Business Name, Email, Tel Number, Website/URL etc.
If you are interested, please let me know your thoughts, so that I can send
you the no of contacts available and the pricing for it.
Awaiting Your Reply
Thanks & Regards,
Cynthia Higgins
Marketing Executive



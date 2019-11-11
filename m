Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A900C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A9420656
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="aF6hEFt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKKImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:42:33 -0500
Received: from mout.web.de ([212.227.15.4]:57963 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfKKImd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573461741;
        bh=WXwGo+5WayyFolgFABu45CgLrxXdmvolIgt2gwJXvAA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aF6hEFt2n+PxBs43Lj3I780vn4XWfLZ9j91bbMhkhasPsJ6ltCxX0KFNfP8kvK61Z
         BwMRrTYdvJWPRFhRp2D31v4a9XZLE6diV7oD3Z2bhZEzIKo+o7Inn85S5NMFpJhGms
         vSY5Qv4r161I2d5IoLFCI1r7prXU8ihTkeUkrXPc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.123.26]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7Kek-1hjWEk30KM-00wzdO; Mon, 11
 Nov 2019 09:42:20 +0100
Subject: Re: [v3] s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
 <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
 <c0df9cc8-c41a-1e5d-811c-1ff045c13fcc@de.ibm.com>
 <61244676-8ac1-20af-ed94-99e19c1f95d5@web.de>
 <040f3e18-d97a-fc32-b237-20e7553e1733@de.ibm.com>
 <c701adc9-dab2-46af-003f-d8a2c47bc0af@web.de>
 <ad1c533d-8e7f-b17e-d9cb-54dd9a7ed012@de.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a2dbda2a-1c2f-20f1-6b97-c59dbbcaa7a8@web.de>
Date:   Mon, 11 Nov 2019 09:42:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ad1c533d-8e7f-b17e-d9cb-54dd9a7ed012@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:+2+/m0/7L2WKtwaoZZt4Obm7pajzpcS7Eq41IvkgacxlJHbiEWB
 Sp0YZcL0lOc3UKhgB2UIz622eGR5VJ+51EozkBmBOHlUhhwDgwmv7m2H8n8F6eDsijACJFZ
 PE0sXCT7NWuunKp1zeHUtncozF7yQ9TKAP6e6SVTHQ7KxFayLmPw64Nj5HewYPHCGDOiWeU
 29vKEx6U/ZEGx1gkiVe0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FWsbDdqbak=:8Fin5ziuXp8AvQcBSjUzo+
 nzhkfaWYJc6Vgxl0PvY3HX7H+RBSegzuirbrEXE+GKzlP7fcrwr0QCHUr8xSAoeCANx43Ql5A
 8Kb0i5IC3Tn3wxR7fcaN9LbLgxk2FbzgvTyqf28i7FveGACizzLUUkhVBBwhufBtZEXNcWXZO
 cJI3DRXfKW+Uxk3Z6Dcz1fb2cX2jfnKKFkecqKC/rwkJwAzRAh+i8kF+OaSgr0XtWzP+avbpN
 vJvN1HzLgoKNJT5AG4hg4NUFqvRRXNrzQvKvqrNmzjJmqc0InIxtowjk/FfI+OkovcfGontCK
 kZj3O1bvbfGa6uqCV61pkHeL3BnWNgj7P+0RsO3IbdvNyRHvCIDU/mtnNyYG3JY/anniCCogx
 H+G1oRTcRiF2ZrInZzDibqosF/cKzXsOERnSP04lpMjz+vZDk2aNu/H+faHDAwCAZOU8j1oO7
 xCTJKQHAKUJLG+m5lDi1X/RCdSpaAyZ+1C+EjH9EK/zSUcuzQFZXHoiJevZua4j7REKu38Ttf
 oYbv2o9QIoUSfX8n3PBPYgQ1M/v3wS2Aurj55stxrsIfB8ZA2Kfwz3bLEtl1lMr4kuKHaAVUp
 4f34Z/ZYcVej+Pyxf/vewL3s6UcMNB/OkD0qbOJ1orR6Nv2fFP6DwGAqcIfSc4QVW8uFqb2t1
 IIDzpwlf5Aqw4LagzrBZIeU5deDvB0mXYWnpFyjtA/1S32cHn5KK0NElA/4WZJTeY/wN1fcsA
 UglKMOIP5RMj++BOdL8ZY3spDsRJF7Nva6wrjlKnwW5dKq12LWiiXPixm2FF4yMMbu9im/I4R
 vDQPvxGFRtZ23NG/BpnhZIUJ728fyf3fsCdg9SxUy0hKZThKh+09aRyEdoLyCGYyYZlU8t5CG
 TvtjdosqoEuHM9mmiWTX/rKMwHJhE4SvYx8FStjSQuMTqPdziIOoCRelHpebM8vi2LlovJEBj
 y4LMv4WuIEt7YVJ7d1R7Z8n7eaeriI9ju/++p+wmfIJ0X3mXji1m/4E40ECxhtyl6I8O+8na3
 0ubtTUZYs+bGHMl9gKeKOkmap7tMfuRAibsziymUCCwIJSL61Lv+hRtIAfEg4vBDNsZOLWm2U
 oxoTDvR7hsHqASTR6DGIMS4Su3Q4iS2awT1ksYqoMtvVnv72LXe5cPb9x1vVEVaQrnA1KFmET
 UG8wnBdY7R8cDR6RMSWhZpb0SFiHclM2J3EPSppGfRY+oXsvMTVjp4yfiL73+uT03YiTD9fqy
 n9/mJhqaJ6DfhEIfpEpGuDPkokvGd3fUUqyMGWH9GH63/bdSuRYQOBzsOL+c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No, I just want to have the word "fix" in the subject.

How do you think about to use the preferred subject in your final commit directly?
(Do you insist on sending a fourth patch variant?)


> If you are OK with changing the sign-off to your web.de address

Does hinder you anything from continuing to use the previous known email address?

Regards,
Markus

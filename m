Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45828C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17148205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veutYtz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfFVP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 11:28:42 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:36066 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVP2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 11:28:42 -0400
Received: by mail-ua1-f48.google.com with SMTP id v20so4129807uao.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nPwq31T/zG3xT1NFQQy/vnu0qnZsJ3CDVx6948lNe+I=;
        b=veutYtz0cNysmrFO6w8vH//7Ix4RRVZgo6d3LWVTCE8xQERoPUZpgMB7B/vC0ToR9G
         Khyoin+4zSI9KN+Q0nCl2p0YAbSXARFbZAVn6uhZmJQkWa2Q/PSzIns1wXhEf3MClhyy
         riVa2hOph1iJLNX0zxdboNAW49q0nXz2UE8+yHPjqI+BCRR5mouRKgBbcPNcRupm/QfN
         ocmaBkKp2tUsPaAzsyySuGuq/Zgy0HOvp0MgxNWY0VVVkSTT4rOKHo38vSvMqRDsar7c
         zy9VI0J3lb4I+SKnE0qQk5SyX3oPN4ziJwy365ew2qQd/lEeiqKBpih8P0Sjio2FKYjx
         M8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nPwq31T/zG3xT1NFQQy/vnu0qnZsJ3CDVx6948lNe+I=;
        b=JtypLG4Db+Vqvf8qbyMr1uykMsw/totcbFgrxVLHv/IwFUKmb4u+4LXPf0fdTq192h
         UOcH+tL4N8Xvs4fZ9/cEEeD+0IgCOwtLMgiAmRhdcaILkShgz1Peqhc+qasSEod3wplj
         39r0d8VR8wwSLkzqHdXtI75X0fcQbBm7yavLiLFl+GXRf5mPHZHRrUlPigTZ323qLBsR
         XFoAp6a83GJvLBEs0mAdor2/YHbtqAWJHAnBLVQlZK41tw5nH4Y/VOKveFGcmNI5kOj+
         F1YBBJvWUnO1zRuCHzzItY1q+k2pevdzKaWmmYDp8rhNdws5wkMbFK2UCqsR0BLFUdAJ
         66Qw==
X-Gm-Message-State: APjAAAU7T1fmjCS4UATP+eMPPbnLzBWbYoqb18+Iz5smRXkiUVVTssCk
        eWEvu6BLnoEpnGBZE1ZikPRXv3yD2CxKRYBi8NyZFu9z
X-Google-Smtp-Source: APXvYqwdKXbggtqi2ODw4JBYlkbzg4GbJUH3YCDJoapFQ6DVS+ufP1STnrIpfNWYR2GWWAyQGTxehUSiC2xSXJudZgU=
X-Received: by 2002:a9f:3770:: with SMTP id a45mr14538349uae.64.1561217320640;
 Sat, 22 Jun 2019 08:28:40 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 22 Jun 2019 20:58:29 +0530
Message-ID: <CAHP4M8Vj-BmDXQgF-rkLr5fthey7RVaZ-1o87yTUg=9uh4hEOw@mail.gmail.com>
Subject: Difference in values of addresses in System.map and /proc/kallsyms
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

My system is

ajay@latitude-3480:~$ uname -a
Linux latitude-3480 4.13.0-38-generic #43~16.04.1-Ubuntu SMP Wed Mar
14 17:48:43 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux


When I see the address for a symbol, say linux_banner, in
/boot/System.map-4.13.0-38-generic, it shows
ffffffff81e00120 R linux_banner

However, when I see it in /proc/kallsyms, it shows
ffffffffa7000120 R linux_banner


Also, I note that /proc/kallsyms addresses vary upon reboots, so I am
a little confused as to what the entries in /proc/kallsyms really
mean.
So, will be grateful for some pointers from the experts :)


Thanks and Regards,
Ajay

Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3548DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47CD206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xs33s452"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfDZOwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:52:31 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:34647 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:52:31 -0400
Received: by mail-qt1-f182.google.com with SMTP id j6so4424699qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=48zgZZm9rHvCEp1pEqUhC0U3faF4KPhZf7qiHf9zYg0=;
        b=Xs33s452X6QtzPCMCAtjr0M4pj8fZRIA6lwgvpWwu/cIIYP/lUyae2OIpm6XQLNdKy
         AWQNsXk+6JWuzUrg6GKOlETU9g2B2AU1vA9bKtiXGdfReOwebMl/ppTKXW2J8Y0dZfke
         eXBK663QRdQNjUz8h+GoZlZb4zEddEdwng4Y8hUmXSOolJ+rYVzC/OUPSxbF7azdFHa2
         jR8sYQsEZbSj2OPxHczSLv61il9kWCTO6EAk8jXPZSFIpt8wchRUjbcNC9jGaPa+dPmX
         v0FQsMmlG4Ik/Tdpqotn/UGz+LGzLLbCmARjsbXN2GOBlVoLTRsehiLvaHRSNtZ+t8XP
         qa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=48zgZZm9rHvCEp1pEqUhC0U3faF4KPhZf7qiHf9zYg0=;
        b=dUPVTH7QL/kgUh7lE2eJMSZzOsGRMyGsAp8g/29kGyuaJALmLMZrCw+jdIHSn/hJpJ
         vne7PGt+ueXOjEHOC9wy6dD9Erz/895Ok32c0A0SOQBLs3F1RbqN4Dcb6tr3vlqXPCAS
         cj4yNlWa52YSeq738FohJ9lEjg9yGACDinVMfyHYCyvkawNV8bhH4QIrbcAD8ImgMe1P
         p5jmqp+Q6nlMN9VoRe7dRY3AafpBwQQbmhEJFnpN5rx4U4sk7+DfEtHdfehnv03UpJL3
         scBvJm56OAcHHUP8GNKLk7Z+i8cDNWN4JOoPciHx9awEurLr5QRVB6JRBcTU9bXUtZOm
         kTew==
X-Gm-Message-State: APjAAAUOhO9tVjH/Ncr/zIK2/zxR9eCDoVRR7GREhmN1YNDklR4ZykUp
        LeIn5XGmv8UGkPNZpinDDcghZg==
X-Google-Smtp-Source: APXvYqwAVI9GU8elWrhSomD5TS/PfqIKCx0Zk29tTGQeDfrgZtmKz7RRurmUfZ4VHuVfmHrwY153mw==
X-Received: by 2002:ac8:379c:: with SMTP id d28mr24803403qtc.91.1556290350226;
        Fri, 26 Apr 2019 07:52:30 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g24sm3642158qkm.25.2019.04.26.07.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 07:52:29 -0700 (PDT)
Message-ID: <1556290348.6132.6.camel@lca.pw>
Subject: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Apr 2019 10:52:28 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applying some memory pressure would causes smartpqi offline even in today's
linux-next. This can always be reproduced by a LTP test cases [1] or sometimes
just compiling kernels.

Reverting the commit "iommu/amd: Set exclusion range correctly" fixed the issue.

[  213.437112] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0x1000 flags=0x0000]
[  213.447659] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
domain=0x0000 address=0x1800 flags=0x0000]
[  233.362013] smartpqi 0000:23:00.0: controller is offline: status code 0x14803
[  233.369359] smartpqi 0000:23:00.0: controller offline
[  233.388915] print_req_error: I/O error, dev sdb, sector 3317352 flags 2000001
[  233.388921] sd 0:0:0:0: [sdb] tag#95 UNKNOWN(0x2003) Result: hostbyte=0x01
driverbyte=0x00
[  233.388931] sd 0:0:0:0: [sdb] tag#95 CDB: opcode=0x2a 2a 00 00 55 89 00 00 01
08 00
[  233.389003] Write-error on swap-device (254:1:4474640)
[  233.389015] Write-error on swap-device (254:1:2190776)
[  233.389023] Write-error on swap-device (254:1:8351936)

[1] /opt/ltp/testcases/bin/mtest01 -p80 -w

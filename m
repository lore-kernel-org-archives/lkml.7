Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9635FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BE2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAyePnvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfHITip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:38:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34510 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHITio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:38:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so45374157plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0jRl4f3hMFvY797VTlUgGgaEZaYTvYyYtEs42v09cM=;
        b=SAyePnvxQx0JTb8PX8WhY8QrOVPChnu5XgHnchPD4uybMDVy0AJkPuretmKny9wovt
         u3uRQU4D+fTOiRjhiWBDzMfstVe4RWOa76oeblYvur1rqCMDa5c485KjmHkyvdILpcAU
         OnIsyR7JA97sd3zqjy6XkejM2p4DYoWckjKjzQhbr1OS1c7f77EBclVMJ7tUSlbaXXNU
         drClDLIyM3UbCMsShQqNqJfeCNQdplGDeMWiUFV8CWhjV7J3U7fBlIZ5e+3W9EV7wK5f
         GyCk+jSlMipL/XhmsrmXsR5Xbi7w3hiNv1m7JNCWw73t4r3+BxtRrtkpKAyAP7VI9n3v
         +53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0jRl4f3hMFvY797VTlUgGgaEZaYTvYyYtEs42v09cM=;
        b=BGDHqo2tr7lzvY9gWqYYsSEqi2mxcRBssybmpF8EsSfiQMoTj5AgY6Cn/uNnPaoVjl
         VfVncY0lTuJEW7BvmDVCQLylAJsbXox2YNAXua+qIZXst8YC2HU5CLVd7S2NQ778ACYw
         UAsi4Ldq13P1Bg/qcxtxJhS36vWSUBrgimZ1xL9FT2T+0KsMSjgIKgAYWOkGWRPu1ZXR
         IpTuDFKVTejQ3N/du8AMlY7u3FS/9dHPnMVW+2LCGqbk9LF7hE5zvpYHWxzZqc1He/Kz
         VmbIhGbL+kW2yuOAdyGJ4Q8OzTYUMObgTwcfus63MYwy+iqVBn7yEQWXWSsz8ak5VI2J
         qMQQ==
X-Gm-Message-State: APjAAAW2YBvzF/9Nq03+LNEYcOPbtKWLEmIEHAOCXtZaE/0frH9vCDgf
        RDt/ivS+xXotH1caTmEPMW8=
X-Google-Smtp-Source: APXvYqzO8KILPyoEvux0/VJWFC86QLoigsWPvQAwfoIB57aBVV81Lvh5KqInxVfA+F4pYN1ysD1Ctw==
X-Received: by 2002:a17:902:e30d:: with SMTP id cg13mr20603895plb.173.1565379524284;
        Fri, 09 Aug 2019 12:38:44 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([2401:4900:277d:9fe5:c098:ab6c:e50:f58c])
        by smtp.gmail.com with ESMTPSA id k25sm83790965pgt.53.2019.08.09.12.38.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 12:38:43 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     jhubbard@nvidia.com, gregkh@linuxfoundation.org, sivanich@sgi.com,
        arnd@arndb.de
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [Linux-kernel-mentees][PATCH v5 0/1] get_user_pages changes 
Date:   Sat, 10 Aug 2019 01:08:16 +0530
Message-Id: <1565379497-29266-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this 5th version of the patch series, I have compressed the patches
of the v2 patch series into one patch. This was suggested by Christoph Hellwig.
The suggestion was to remove the pte_lookup functions and use the 
get_user_pages* functions directly instead of the pte_lookup functions.

There is nothing different in this series compared to the v2
series, It essentially compresses the 3 patches of the original series
into one patch.

This series survives a compile test.

Bharath Vedartham (1):
  sgi-gru: Remove *pte_lookup functions

 drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 88 deletions(-)

-- 
2.7.4


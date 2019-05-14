Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87047C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572BC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2KCHHXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENQSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:18:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42195 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:18:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so19886131wrb.9;
        Tue, 14 May 2019 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QCo8Dha4jyH5qWVup39lkl3qNYvyEmFp/lbafcwv0g=;
        b=M2KCHHXa9w7/0ORsFwfWWtv8dG1WOl97mnj3NEraBVfUPCaS3RJyCUsg0aDol2crMV
         raEb9PUzHG/xhP6y6ugm6qvILLGa8UEU//4WsgOZwBDbII7z1cevZXlD4xywNq1wcR3Q
         w0Vl+YrMkTKbMLgJp0H3HliVuCckDZBdoFKx7fzPBO/OP8Bc3AwQp6gVMUSaF7QEvZGu
         fItLVS3WYog+yqtkIDBHgRL18EcAfR1z0ve0HPcxOTPQ28xswqyWZui5KWr/1olovf0n
         +NHrQUziMAS0fVm1Eb/wlwZy0NNHp+wKWJ+bUCFve3NAgimjqazbg1jOtDQ4Tar7EQyR
         Gfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QCo8Dha4jyH5qWVup39lkl3qNYvyEmFp/lbafcwv0g=;
        b=Px6Am08Sc8pZMS0XDS3UK8hu/9OZ6BfA0340oCsC0jq5L3YaxvSFx8auPLICltvILE
         xseFaWz5AM1NX7WK4LO5MWL+b4uRAO7rKRkIN44chvvL+qCR9dhQk4aGfqyXx08tSqtN
         Znw8we9UT9V8TxKADjYmDwvG/acKzRPpeUrFfnsVQ0dgUXaATsDDUxtKD+VsedxAaUqM
         F+Kgcr2wb6X6rfCljMgpIAn/VJs1C4+Ei7i+M0XZzl+FjvB7BgIAdT7lLEoeWFCJobae
         HyM9SUJ7IcI2ipepegjKDtka/9/tckE54BNKYOsdqP/yUNJqiW3tKb1lsUE7FPxVrrAF
         Ivww==
X-Gm-Message-State: APjAAAWdEuvntDOz5kt4AOf41L9R6Bv+gyV084MqAyaWta8HE49HkaVY
        6+dXcPi5xuqfjkf+VKXPL3s=
X-Google-Smtp-Source: APXvYqxYdKqSrZRWSHsMpQlKO7iixoLljsIATMn2P6fIRC02plxoPJYE12VcGiTDYRt10LFDD8Y+Wg==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr14777198wrw.225.1557850699692;
        Tue, 14 May 2019 09:18:19 -0700 (PDT)
Received: from nexussix.ar.arcelik ([84.44.14.233])
        by smtp.gmail.com with ESMTPSA id d16sm15422987wrs.68.2019.05.14.09.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 09:18:19 -0700 (PDT)
From:   Cengiz Can <cengizc@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cengizc@gmail.com
Subject: [PATCH] Documentation: kdump: fix minor typo
Date:   Tue, 14 May 2019 19:17:25 +0300
Message-Id: <20190514161724.16604-1-cengizc@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdump.txt had a minor typo.

Signed-off-by: Cengiz Can <cengizc@gmail.com>
---
 Documentation/kdump/kdump.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 51814450a7f8..3162eeb8c262 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -410,7 +410,7 @@ Notes on loading the dump-capture kernel:
 * Boot parameter "1" boots the dump-capture kernel into single-user
   mode without networking. If you want networking, use "3".
 
-* We generally don' have to bring up a SMP kernel just to capture the
+* We generally don't have to bring up a SMP kernel just to capture the
   dump. Hence generally it is useful either to build a UP dump-capture
   kernel or specify maxcpus=1 option while loading dump-capture kernel.
   Note, though maxcpus always works, you had better replace it with
-- 
2.21.0


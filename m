Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4816C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626220663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfDPUWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:22:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfDPUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:22:38 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPK73-1hV74f1wth-00PhZT; Tue, 16 Apr 2019 22:22:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Yan, Zheng" <zyan@redhat.com>, stable@vger.kernel.org,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org
Subject: [PATCH v3 11/26] ceph: fix compat_ioctl for ceph_dir_operations
Date:   Tue, 16 Apr 2019 22:19:49 +0200
Message-Id: <20190416202013.4034148-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ncSG/iqiJvmm61j4vsNYbdHxz+1auh9LAHdlTe/IOePGsBdJynV
 0RyxbgpRCJQJpC/0kJtvXMy4qSCF2h1YXQ2NLyZW/bsDz4ednUxHq+Eh8XDmIFJ2cNFZIlV
 GQOVEHRoDY19ALYhS3sJGpEg4XhKCYKfTdlgjRS4R8x2MoPpSabUnxdWH2Ffnipn1QEvTWj
 8/j3UT1dHvyxs3MwCUwSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Io/DT0YbMVc=:hWKcfZ9kn+e5xqhBna7DgQ
 TGsuOgDATCLBVV55VG/VX21kQaI4STQh4untrqriqS7sDUBknRlzuzaSlKs10HWOT6VW31+3b
 X9E5mo+jVbSS2TOAQGh5+7UprNfn/Xesv2pa+yfiAgeWK5b4dRugLrrmIxe9o2YsKIeidO3yV
 t/nUkg0ZQDZIMfDPVukY+lSqnFffLgwNk5fREDXR1NeTX1uUfhQ4mxRhfh/CsOZdshY93oicG
 rCRcEt3ke8kcmhYJ502Os253aGLd+kjyTo7jPDXI2I1rNtobWd4s/egDIEoTFMSBSajcL8NsB
 yCeiHoC3ILDYJ8EGuqg+2qLM2P9pr/+BOVHeXaZwjQFKNBRYRL8oJobJvgje6jddkyLtCW/SW
 6DcYYFBjNSBavMvW3l9KuwIgWJR/Lq3BJQna+P7xfEilKBfiMSUf3FfpN4mg2X4NEmsmwkfFQ
 VmU6vnjZXhXqEn/itXrXOfyFK6SJnBHw8Lll/kSierrmKBViLr2NZojayKAzAvDHMqI53IfUM
 Npv5vhJ5RE4g9yH4wLhE/yOEt9Q22OFt1S72QqJ3XKJBr9IVEV+h8A+boePpSv5ThTW+HMVqX
 0T9Mnkdy+QV/EXodhbEfd3PdtmL7SLH22aw4cqQzhOFq9hMGjZQGu9M7R4BKTEeRLRwt9Js95
 Z3I5jKuDF7fgmlwlQG1bnx4AE/fa8TGTaZzURORnWpRROH4pUgYh2aQILg4odwY0O+A0hJMSw
 DMKJO6vl6crLloVuEWyT0hSyhXQRwa0/bULRXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ceph_ioctl function is used both for files and directories, but only
the files support doing that in 32-bit compat mode.

For consistency, add the same compat handler to the dir operations
as well.

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a8f429882249..7c060cb22aa3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1785,6 +1785,7 @@ const struct file_operations ceph_dir_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
 	.unlocked_ioctl = ceph_ioctl,
+	.compat_ioctl = ceph_ioctl,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
-- 
2.20.0


Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243C521848
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211473;
	bh=ducbvbvTebvGptEQe/6xKp5AEyQgn3Bc0/DQdWbjwVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LsVmaMTEDz5UvXr7Pmyyf//cA2HVqTME+EopAXjP+4796b8lAKWHkQEHRGYLKRdWF
	 gCCYaR9LzCniELq6VUi7aVvQxxvugqghIwTCQa7znHRmw0ah+V09HHsLSzIsMy0fs0
	 e0vVfyYTTpfKzMkBMciCm88JTPStVdPLIqGGd1X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfJ0VYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732524AbfJ0VY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:24:29 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9F521848;
        Sun, 27 Oct 2019 21:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211468;
        bh=ducbvbvTebvGptEQe/6xKp5AEyQgn3Bc0/DQdWbjwVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOiZoxwKEsxRVSZTjTOmDVrPfr3Ccaeb4/NfrntDLWPz1OF4pc50GoPpW2gqQGSJ5
         Z7EYcDoiUlBmpbKrJsPH3r3IAfjPLqOblS9E+JRCA3c1802xKoN721Ofq+0svsSSx/
         qpuoejKqjE5XJQAF7vgGGlSFROy/IklwtRbpyO+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philip Yang <Philip.Yang@amd.com>,
        Joe Barnett <thejoe@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.3 135/197] drm/amdgpu: user pages array memory leak fix
Date:   Sun, 27 Oct 2019 22:00:53 +0100
Message-Id: <20191027203359.001669494@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203351.684916567@linuxfoundation.org>
References: <20191027203351.684916567@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

commit 209620b422945ee03cebb03f726e706d537b692d upstream.

user_pages array should always be freed after validation regardless if
user pages are changed after bo is created because with HMM change parse
bo always allocate user pages array to get user pages for userptr bo.

v2: remove unused local variable and amend commit

v3: add back get user pages in gem_userptr_ioctl, to detect application
bug where an userptr VMA is not ananymous memory and reject it.

Bugzilla: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1844962

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Tested-by: Joe Barnett <thejoe@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.3
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -536,7 +536,6 @@ static int amdgpu_cs_list_validate(struc
 
 	list_for_each_entry(lobj, validated, tv.head) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(lobj->tv.bo);
-		bool binding_userptr = false;
 		struct mm_struct *usermm;
 
 		usermm = amdgpu_ttm_tt_get_usermm(bo->tbo.ttm);
@@ -553,7 +552,6 @@ static int amdgpu_cs_list_validate(struc
 
 			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm,
 						     lobj->user_pages);
-			binding_userptr = true;
 		}
 
 		if (p->evictable == lobj)
@@ -563,10 +561,8 @@ static int amdgpu_cs_list_validate(struc
 		if (r)
 			return r;
 
-		if (binding_userptr) {
-			kvfree(lobj->user_pages);
-			lobj->user_pages = NULL;
-		}
+		kvfree(lobj->user_pages);
+		lobj->user_pages = NULL;
 	}
 	return 0;
 }



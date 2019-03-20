Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F86C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA1A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8oTTR8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCTPo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:44:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36483 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCTPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:44:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id e4so2412565edi.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TZEW0QTWGI2itMTHEFhP2D9fIsafqR333YOhPjFNM9w=;
        b=S8oTTR8rzERcSJwEOu+GkBultmNYvDzxXsHzEg/geBsb7vIO/tzxgLghyaPQtd72jw
         MK2Ax9rgl9NlkUpyrafYOTrHRUjYxbqB48/FPq6sHpzPaYJAZGoFAhtfCJdLxm0mIYum
         FQIH6Ai/kRPwHtSJ+LhwMO+3+4/IHYDwN7VHxHWeEl+9vtu5S5JGvoHtKeZ253TRyTep
         IM/2okJTLrozWNjWT3nFYoEzp6tdNWNC3PBrjOZi5T1SWyaIa8888nPM9/MwMsvlJCLn
         vf/7bwUx85FujgFKsv9kXu3mlC+YJh56D/o34ARJmE5gjPULgKD+hah42rsFb8Mo7DzK
         F4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TZEW0QTWGI2itMTHEFhP2D9fIsafqR333YOhPjFNM9w=;
        b=fvowBmQJ3UOQaj9rUZeFxGnrBrG7cS3A4slHZBuhmrNw5hTqC5utmRm2FhKp81Oc95
         zPXT87H6ibXF6x+fj1ffP/VJfKCuPt6iH/mFrZGbry8oWs0jzPM7IuZQGJ6OtyZigZ0d
         qjVd/B2a5ZJ9vwUvkzs+HCUFOLjDw34lkTa4mCOKd/1UXSmiKuJUE9OSaZ834LgCPOAb
         Vy0qO833Gl0s1suT2j24Fg0XmI+Uzotk4nVnvltdn5IQdDPzpU3xWlNFUWRZuyqfOWu2
         HRmTqCV4Iu+Hby+gkAN8PkgsmMJLz58yMeV3V3Ue/zedqC9LqtNLgRuiTUPLOF8Eemd9
         0g7Q==
X-Gm-Message-State: APjAAAXrNnB7luwsBBFnR7Kt3rLHgjfr9hlfKfUvPQsrWu04wwueH0PK
        A5h+/ciD5xffjvzLQ2vkQfE=
X-Google-Smtp-Source: APXvYqzB8yVo4kaPKlKqDJ6nw5+BGhB059mp+BR/LB98HeLoMk23pCHZzvHpO5kj5UlWNuCl+m6x2A==
X-Received: by 2002:a50:f4ee:: with SMTP id v43mr7952998edm.25.1553096693347;
        Wed, 20 Mar 2019 08:44:53 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id a51sm741963edd.57.2019.03.20.08.44.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 08:44:52 -0700 (PDT)
Date:   Wed, 20 Mar 2019 08:44:50 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stephen Hines <srhines@google.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
Message-ID: <20190320154450.GA20310@archlinux-ryzen>
References: <20190320005406.GA16412@archlinux-ryzen>
 <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen>
 <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
 <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 07:58:09AM -0700, Stephen Hines wrote:
> Why are there 2 different enums for this same thing at all? By casting, you
> are reducing type safety in the kernel, which can cause bugs later (should
> the two enums diverge in encoding). In my opinion, the proper solution is
> to remove one of the enums or provide an explicit helper that does the
> conversion (along with assertions for handling any unexpected cases). The
> helper function should not be doing a direct cast, since a bug could change
> the integer value of one (or both) of these enums so that they don't match
> up.
> 
> Thanks,
> Steve
> 

Indeed, I would suggest something like this (if this was to be a build
time error, this would need to be a macro instead of a function):

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a71668b8a7d0..451478cf4f35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -541,13 +541,13 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 
 	if (!enable) {
 		info.disable_features = (struct ta_ras_disable_features_input) {
-			.block_id =  head->block,
-			.error_type = head->type,
+			.block_id =  amdgpu_ras_block_to_ta(head->block),
+			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
 	} else {
 		info.enable_features = (struct ta_ras_enable_features_input) {
-			.block_id =  head->block,
-			.error_type = head->type,
+			.block_id =  amdgpu_ras_block_to_ta(head->block),
+			.error_type = amdgpu_ras_error_to_ta(head->type),
 		};
 	}
 
@@ -647,8 +647,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
 	struct ta_ras_trigger_error_input block_info = {
-		.block_id = info->head.block,
-		.inject_error_type = info->head.type,
+		.block_id = amdgpu_ras_block_to_ta(info->head.block),
+		.inject_error_type = amdgpu_ras_error_to_ta(info->head.type),
 		.sub_block_index = info->head.sub_block_index,
 		.address = info->address,
 		.value = info->value,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7a35316baab0..c8576ab6e057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -197,6 +197,64 @@ static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,
 	return 0;
 }
 
+static inline enum ta_ras_block
+amdgpu_ras_block_to_ta(enum amdgpu_ras_block block)
+{
+	switch (block) {
+	case AMDGPU_RAS_BLOCK__UMC:
+		return TA_RAS_BLOCK__UMC;
+	case AMDGPU_RAS_BLOCK__SDMA:
+		return TA_RAS_BLOCK__SDMA;
+	case AMDGPU_RAS_BLOCK__GFX:
+		return TA_RAS_BLOCK__GFX;
+	case AMDGPU_RAS_BLOCK__MMHUB:
+		return TA_RAS_BLOCK__MMHUB;
+	case AMDGPU_RAS_BLOCK__ATHUB:
+		return TA_RAS_BLOCK__ATHUB;
+	case AMDGPU_RAS_BLOCK__PCIE_BIF:
+		return TA_RAS_BLOCK__PCIE_BIF;
+	case AMDGPU_RAS_BLOCK__HDP:
+		return TA_RAS_BLOCK__HDP;
+	case AMDGPU_RAS_BLOCK__XGMI_WAFL:
+		return TA_RAS_BLOCK__XGMI_WAFL;
+	case AMDGPU_RAS_BLOCK__DF:
+		return TA_RAS_BLOCK__DF;
+	case AMDGPU_RAS_BLOCK__SMN:
+		return TA_RAS_BLOCK__SMN;
+	case AMDGPU_RAS_BLOCK__SEM:
+		return TA_RAS_BLOCK__SEM;
+	case AMDGPU_RAS_BLOCK__MP0:
+		return TA_RAS_BLOCK__MP0;
+	case AMDGPU_RAS_BLOCK__MP1:
+		return TA_RAS_BLOCK__MP1;
+	case AMDGPU_RAS_BLOCK__FUSE:
+		return TA_RAS_BLOCK__FUSE;
+	default:
+		WARN(1, "amdgpu_ras_block_to_ta fell through with a value of %d\n", block);
+		return TA_RAS_BLOCK__UMC;
+	}
+}
+
+static inline enum ta_ras_error_type
+amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error)
+{
+	switch (error) {
+	case AMDGPU_RAS_ERROR__NONE:
+		return TA_RAS_ERROR__NONE;
+	case AMDGPU_RAS_ERROR__PARITY:
+		return TA_RAS_ERROR__PARITY;
+	case AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE:
+		return TA_RAS_ERROR__SINGLE_CORRECTABLE;
+	case AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE:
+		return TA_RAS_ERROR__MULTI_UNCORRECTABLE;
+	case AMDGPU_RAS_ERROR__POISON:
+		return TA_RAS_ERROR__POISON;
+	default:
+		WARN(1, "amdgpu_ras_error_to_ta fell through with a value of %d\n", error);
+		return TA_RAS_ERROR__NONE;
+	}
+}
+
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
 void amdgpu_ras_post_init(struct amdgpu_device *adev);

> On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian <Christian.Koenig@amd.com>
> wrote:
> 
> > Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
> > > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
> > >> these two enumerated types are same for now. both of them might change
> > in the future.
> > >>
> > >> I have not used clang, but would  .block_id =  (int)head->block fix
> > your warning? If such change is acceptable, I can make one then.
> > >>
> > >> Thanks
> > >> xinhui
> > >>
> > >>
> > >> -----Original Message-----
> > >> From: Nathan Chancellor <natechancellor@gmail.com>
> > >> Sent: 2019年3月20日 8:54
> > >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <
> > Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>;
> > Pan, Xinhui <Xinhui.Pan@amd.com>
> > >> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> > >> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > >>
> > >> Hi all,
> > >>
> > >> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: add
> > amdgpu_ras.c to support ras (v2)") introduces the following Clang
> > >> warnings:
> > >>
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_block' to different
> > enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> > >>                          .block_id =  head->block,
> > >>                                       ~~~~~~^~~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_error_type' to different
> > enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> > >>                          .error_type = head->type,
> > >>                                        ~~~~~~^~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_block' to different
> > enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> > >>                          .block_id =  head->block,
> > >>                                       ~~~~~~^~~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_error_type' to different
> > enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> > >>                          .error_type = head->type,
> > >>                                        ~~~~~~^~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_block' to different
> > enumeration type 'enum ta_ras_block' [-Wenum-conversion]
> > >>                  .block_id = info->head.block,
> > >>                              ~~~~~~~~~~~^~~~~
> > >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit
> > conversion from enumeration type 'enum amdgpu_ras_error_type' to different
> > enumeration type 'enum ta_ras_error_type' [-Wenum-conversion]
> > >>                  .inject_error_type = info->head.type,
> > >>                                       ~~~~~~~~~~~^~~~
> > >> 6 warnings generated.
> > >>
> > >> Normally, I would sent a fix for this myself but I am not entirely sure
> > why these two enumerated types exist when one would do since they have the
> > same values minus the prefix. In fact, the ta_ras_{block,error_type} values
> > are never used aside from being defined. Some clarification would be
> > appreciated.
> > >>
> > >> Thank you,
> > >> Nathan
> > > Hi Xinhui,
> > >
> > > Yes, explicitly casting these six spots to int would resolve this
> > > warning.
> >
> > Another question is if it is such a good idea to just silence the warning?
> >
> > Maybe add a amdgpu_ras_error_to_ta() helper to do this casting?
> >
> > When the enums drift away from each other then we can still add warnings
> > to that helper to make sure we don't accidentally cast invalid values
> > around.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Thank you for the quick response!
> > > Nathan
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> > "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> > email to clang-built-linux+unsubscribe@googlegroups.com.
> > To post to this group, send email to clang-built-linux@googlegroups.com.
> > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/clang-built-linux/63518f1f-b808-77b0-aac6-ee1ece669c4b%40amd.com
> > .
> > For more options, visit https://groups.google.com/d/optout.
> >

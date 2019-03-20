Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F3AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48CF2186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEx0lshX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfCTPct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:32:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40813 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:32:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so2368555edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOsFP3DDoy1KAUPRkqHaAbQaMgIKB2bS4OMcK0PDoEg=;
        b=mEx0lshXZDnd23fljYVqbvWPmSHcIlyZ1MUM1GNJRnBOo8UnT7NgycC5z7PpJ0i01t
         HZSfY9zwoW5+kPgoA62hWRMBogiIzsameqX35pYc0AVV75+/zAgxTXzDmuNf8FWLK0SH
         exdI0gxZWFgwAWEpV+UT7zN+/ug4UkzNsnBt8d/BdHDGpZsCT6mUP/EAG+0Z9eoNPbOq
         qO9ONI27Wp5WqrKkWW2UcK2LQlFMPsDXx7qgxRNTCwRd/xG5q67H8II0reesMv2CkqBa
         rq4U8dzZZvtwAjzLxJZ6TFjHE8x6tP6g3ZNH20IJfHoC0v04RL/H+OahUGLtDDuwqNGA
         t55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOsFP3DDoy1KAUPRkqHaAbQaMgIKB2bS4OMcK0PDoEg=;
        b=mYxHH5APQ+tBbisSyjRvI1tq1318igGhIXs1Biz4oFxxqVtyarIdBbC953c5MXzHu4
         TgaQOgf3vIVAU38MhKB9+gsnE8Fy6RmXkBJIGaaoP7xjn71pIRsKETGAvz4fpmHUNIQ1
         CLMV17zCoNcszMgNcSWnjhwU8RMfwUqhredQYKUx7t+gC1M8PKD+LcWpJK/zJENTjNTU
         mrhSJd6mgM8q0b0x1FkNql8oVwLr/ZP1NZVtEpi3pUbfn1+hmuQmnUduEqVKRqxRb/5F
         frXt149I4E/mh4n5JQ7ToMKDnn3kDyTUl66fdd+G7dSb0n0I+h/qYFPQBVPlw1UijdL7
         +p3g==
X-Gm-Message-State: APjAAAVpXp5w6TbyXqHrp+lLFLtZLU7+KNW/7XidlB67AkxovzduN89y
        SF/Or9f0bNNXOBKHEdNqcWMgVhZ2cmMwoJBqXaKkqQ==
X-Google-Smtp-Source: APXvYqz2gMHVWvPVaZMyiAZQJlmUupD21j5yoN48LRX6sbJSIcTfdMX/ib3VdEqVIm+H5QluxX2q7SZjRWXdvU2sxBo=
X-Received: by 2002:a50:aeec:: with SMTP id f41mr3012255edd.279.1553095966726;
 Wed, 20 Mar 2019 08:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190320005406.GA16412@archlinux-ryzen> <SN6PR12MB280017BDAB60B61088B221C287410@SN6PR12MB2800.namprd12.prod.outlook.com>
 <20190320043440.GA23335@archlinux-ryzen> <63518f1f-b808-77b0-aac6-ee1ece669c4b@amd.com>
 <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
In-Reply-To: <CAAzmS6_LL1bveq0HaHMqE-T2ciuZu=zd4HOFfwW99P1n0cmakA@mail.gmail.com>
From:   Stephen Hines <srhines@google.com>
Date:   Wed, 20 Mar 2019 08:32:35 -0700
Message-ID: <CAAzmS6-pyH7TJ1A5i8J16ioZDCvwJb+kfu7Et-LnNNmyGnmabA@mail.gmail.com>
Subject: Re: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as plain-text to rest of list.

Steve

On Wed, Mar 20, 2019 at 7:58 AM Stephen Hines <srhines@google.com> wrote:
>
> Why are there 2 different enums for this same thing at all? By casting, y=
ou are reducing type safety in the kernel, which can cause bugs later (shou=
ld the two enums diverge in encoding). In my opinion, the proper solution i=
s to remove one of the enums or provide an explicit helper that does the co=
nversion (along with assertions for handling any unexpected cases). The hel=
per function should not be doing a direct cast, since a bug could change th=
e integer value of one (or both) of these enums so that they don't match up=
.
>
> Thanks,
> Steve
>
> On Wed, Mar 20, 2019 at 2:37 AM Koenig, Christian <Christian.Koenig@amd.c=
om> wrote:
>>
>> Am 20.03.19 um 05:34 schrieb Nathan Chancellor:
>> > On Wed, Mar 20, 2019 at 01:31:27AM +0000, Pan, Xinhui wrote:
>> >> these two enumerated types are same for now. both of them might chang=
e in the future.
>> >>
>> >> I have not used clang, but would  .block_id =3D  (int)head->block fix=
 your warning? If such change is acceptable, I can make one then.
>> >>
>> >> Thanks
>> >> xinhui
>> >>
>> >>
>> >> -----Original Message-----
>> >> From: Nathan Chancellor <natechancellor@gmail.com>
>> >> Sent: 2019=E5=B9=B43=E6=9C=8820=E6=97=A5 8:54
>> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian=
 <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; P=
an, Xinhui <Xinhui.Pan@amd.com>
>> >> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; l=
inux-kernel@vger.kernel.org; clang-built-linux@googlegroups.com
>> >> Subject: Clang warning in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> >>
>> >> Hi all,
>> >>
>> >> The introduction of this file in commit dbd249c24427 ("drm/amdgpu: ad=
d amdgpu_ras.c to support ras (v2)") introduces the following Clang
>> >> warnings:
>> >>
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:544:23: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_block' to different enumerat=
ion type 'enum ta_ras_block' [-Wenum-conversion]
>> >>                          .block_id =3D  head->block,
>> >>                                       ~~~~~~^~~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:545:24: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_error_type' to different enu=
meration type 'enum ta_ras_error_type' [-Wenum-conversion]
>> >>                          .error_type =3D head->type,
>> >>                                        ~~~~~~^~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:549:23: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_block' to different enumerat=
ion type 'enum ta_ras_block' [-Wenum-conversion]
>> >>                          .block_id =3D  head->block,
>> >>                                       ~~~~~~^~~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:550:24: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_error_type' to different enu=
meration type 'enum ta_ras_error_type' [-Wenum-conversion]
>> >>                          .error_type =3D head->type,
>> >>                                        ~~~~~~^~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:650:26: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_block' to different enumerat=
ion type 'enum ta_ras_block' [-Wenum-conversion]
>> >>                  .block_id =3D info->head.block,
>> >>                              ~~~~~~~~~~~^~~~~
>> >> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:651:35: warning: implicit con=
version from enumeration type 'enum amdgpu_ras_error_type' to different enu=
meration type 'enum ta_ras_error_type' [-Wenum-conversion]
>> >>                  .inject_error_type =3D info->head.type,
>> >>                                       ~~~~~~~~~~~^~~~
>> >> 6 warnings generated.
>> >>
>> >> Normally, I would sent a fix for this myself but I am not entirely su=
re why these two enumerated types exist when one would do since they have t=
he same values minus the prefix. In fact, the ta_ras_{block,error_type} val=
ues are never used aside from being defined. Some clarification would be ap=
preciated.
>> >>
>> >> Thank you,
>> >> Nathan
>> > Hi Xinhui,
>> >
>> > Yes, explicitly casting these six spots to int would resolve this
>> > warning.
>>
>> Another question is if it is such a good idea to just silence the warnin=
g?
>>
>> Maybe add a amdgpu_ras_error_to_ta() helper to do this casting?
>>
>> When the enums drift away from each other then we can still add warnings
>> to that helper to make sure we don't accidentally cast invalid values
>> around.
>>
>> Regards,
>> Christian.
>>
>> >
>> > Thank you for the quick response!
>> > Nathan
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to clang-built-linux+unsubscribe@googlegroups.com.
>> To post to this group, send email to clang-built-linux@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msg=
id/clang-built-linux/63518f1f-b808-77b0-aac6-ee1ece669c4b%40amd.com.
>> For more options, visit https://groups.google.com/d/optout.

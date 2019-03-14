Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AAAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7571217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuuD3fX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCNDkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:40:03 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37273 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCNDkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:40:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id n7so3126452oic.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 20:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hNTFzygChnirwRrUcMEFd8emtG1u/HxAXbAaftc32aQ=;
        b=iuuD3fX5xAb1/0AVqAlVPsC/JvXxlyCEK2nuc3zEvz8Ld10M4k4TBf0bUysMjRGYiC
         Ktx+V6a1GtX6xYNmgapUkpagV3K2JCg+THpKzIVTcEptpolSQ7OuNktcaZdVluOI2oOR
         zWa7WtM7L1Bp4I2UxOQj4h3F4gZV8erVTcfj22xBtKzWPnmdQ/ZwihxTk53UfBGWGU8Z
         UvxCN7pXyY/V5fb4YRXa32CcbyR5YDmm9Jy9PXILjFMV4WdJPOIJhVizx4wTvNRuipk+
         uptU6OIy3D1EyiVIIQSIx8OJd+Et8wT10FkTOaxQwUlDN8kdBLPpP7yixwiPPpJyJIMD
         TIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hNTFzygChnirwRrUcMEFd8emtG1u/HxAXbAaftc32aQ=;
        b=Q4KmDVXHMhHKT+r/n1jvKbNGq0VwP7xdcefJkKmTBcKiRJNmKT2mph1Y8J/nZ1nR3D
         Ptf8o+bV7L8QwfgKsUkj6OsfHXFbJVNP5aTodhKpF0DBcDD4WFOUclvoEa4KLYfN+xDA
         nVGX4YvIPyfsSv4IBwU0SxuV/MneR1SRkh45A6o5EiYnEekicnhCal6nxenlyWwlBGY/
         WewgLjZOuHJhYyFnuD6C5/SGdgWD6fCX0qe4DeMmzP6YekOYdkYd8mGbh8oyKFluOjWG
         vcVoHSsAS1uRxe0TlfskFITD26oXF/Qo08YuvknBYo1VvmEFXwj1R+0o4xXLNBIZTe3I
         lLoA==
X-Gm-Message-State: APjAAAVL33DbCPXn6UNghkRd5LYyeywjWwIGYI32LjIPuX7SjvlTFwAW
        FZZWAKt9q7CLe6p0704lx+deVpW/3M2R9KZ3sC7Eu5aZ6Ow=
X-Google-Smtp-Source: APXvYqzV3y8pU8UcW2+jf911XVNUlvlp/mlNIGw1dGDdsluhz42ikFE7aEFDXNyfRCn4GZj0FwJUVAuIbALNVOWesW4=
X-Received: by 2002:aca:5dc1:: with SMTP id r184mr789279oib.127.1552534801679;
 Wed, 13 Mar 2019 20:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2503:0:0:0:0:0 with HTTP; Wed, 13 Mar 2019 20:40:01
 -0700 (PDT)
From:   Alec Ari <neotheuser@gmail.com>
Date:   Wed, 13 Mar 2019 22:40:01 -0500
Message-ID: <CAM5Ud7OM3gW9QB-dNe4=FosZZK9+pYEFu4QSfB5j3PcdJ45fMA@mail.gmail.com>
Subject: Compiling error if CONFIG_CPU_SUP_INTEL is disabled
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_CPU_SUP_INTEL is disabled with either the 5.0.2 or 4.20.16
kernel, it errors out right away:

In file included from arch/x86/events/amd/core.c:8:
arch/x86/events/amd/../perf_event.h:1035:45: warning: =E2=80=98struct
cpu_hw_event=E2=80=99 declared inside parameter list will not be visible
outside of this definition or declaration
 static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
                                             ^~~~~~~~~~~~
arch/x86/events/amd/../perf_event.h:1040:45: warning: =E2=80=98struct
cpu_hw_event=E2=80=99 declared inside parameter list will not be visible
outside of this definition or declaration
 static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
                                             ^~~~~~~~~~~~
  CC      arch/x86/events/amd/uncore.o
  CC      arch/x86/events/amd/ibs.o
  AR      kernel/bpf/built-in.a
  CC      kernel/cgroup/cgroup.o
In file included from arch/x86/events/amd/ibs.c:19:
arch/x86/events/amd/../perf_event.h:1035:45: warning: =E2=80=98struct
cpu_hw_event=E2=80=99 declared inside parameter list will not be visible
outside of this definition or declaration
 static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
                                             ^~~~~~~~~~~~
arch/x86/events/amd/../perf_event.h:1040:45: warning: =E2=80=98struct
cpu_hw_event=E2=80=99 declared inside parameter list will not be visible
outside of this definition or declaration
 static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
                                             ^~~~~~~~~~~~
  AR      arch/x86/events/amd/built-in.a
  CC      arch/x86/events/core.o
In file included from arch/x86/events/core.c:44:
arch/x86/events/perf_event.h:1035:45: warning: =E2=80=98struct cpu_hw_event=
=E2=80=99
declared inside parameter list will not be visible outside of this
definition or declaration
 static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
                                             ^~~~~~~~~~~~
arch/x86/events/perf_event.h:1040:45: warning: =E2=80=98struct cpu_hw_event=
=E2=80=99
declared inside parameter list will not be visible outside of this
definition or declaration
 static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
                                             ^~~~~~~~~~~~
arch/x86/events/core.c: In function =E2=80=98free_fake_cpuc=E2=80=99:
arch/x86/events/core.c:1998:20: error: passing argument 1 of
=E2=80=98intel_cpuc_finish=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  intel_cpuc_finish(cpuc);
                    ^~~~
In file included from arch/x86/events/core.c:44:
arch/x86/events/perf_event.h:1040:59: note: expected =E2=80=98struct
cpu_hw_event *=E2=80=99 but argument is of type =E2=80=98struct cpu_hw_even=
ts *=E2=80=99
 static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
                                      ~~~~~~~~~~~~~~~~~~~~~^~~~
arch/x86/events/core.c: In function =E2=80=98allocate_fake_cpuc=E2=80=99:
arch/x86/events/core.c:2012:25: error: passing argument 1 of
=E2=80=98intel_cpuc_prepare=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  if (intel_cpuc_prepare(cpuc, cpu))
                         ^~~~
In file included from arch/x86/events/core.c:44:
arch/x86/events/perf_event.h:1035:59: note: expected =E2=80=98struct
cpu_hw_event *=E2=80=99 but argument is of type =E2=80=98struct cpu_hw_even=
ts *=E2=80=99
 static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
                                      ~~~~~~~~~~~~~~~~~~~~~^~~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:291: arch/x86/events/core.o] Error 1
make[1]: *** [scripts/Makefile.build:516: arch/x86/events] Error 2
make: *** [Makefile:1058: arch/x86] Error 2

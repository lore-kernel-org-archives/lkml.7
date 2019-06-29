Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0483CC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17CC214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFuj1jqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfF2O35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:29:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33096 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfF2O34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:29:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so4865056plo.0;
        Sat, 29 Jun 2019 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IzEQFdLkePu8S+e70/CK1YpMHu8Z2SM5sgKtoalqcfg=;
        b=aFuj1jqXXQJCz3Hl02arAoLjlgbIKdNTNoDFc4BFx1tkZljTyURdf0CVi7p7EOYujO
         O4+v6wBK+aY0IPtlxAkeQ8NZLmQTWGXhBC5qeBFpa/UmHEmnCx5XwFtW0fNrT+X/6leu
         CS0f78c5ZkkJwKIZgdR6xqJXawmNxBX5Rz3KPbQiS3Cpwn7h6P0sUNLk4kfvBY7f6obU
         ASuIVnJ3O6AcScGHHjoOAMNHdf++iBjV5tb9k25wsqojPTMZXP71qdlMbK49lljPxqzT
         BtXjHwqSnAoE1Q42/FIw5dDBX49/Rw3rOko1K4jJRgv0rg5x9HM7c4Qgq8y+hMgkFss2
         uOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IzEQFdLkePu8S+e70/CK1YpMHu8Z2SM5sgKtoalqcfg=;
        b=ptAN9WS/AtOyvVJDQPt3BeLLr20NmeKZN6E3GLTkcbztmKWgNATW8tMa1X96M8yc05
         OWoCYbrTQ+oVixVNE507IFaqdfSJV9VSvG3+CGPSdQ8qat3+68Mcgbg06qnV4CaE+qnb
         qTRFWTCR4PtWawtK557NWRtLEXUTYMYqwTd98hUHhHXgqXXnRzX1exzjHWdkMG38AmBE
         h35Jb1mz/fZEW8tPC0sNoe9K2QKQ5TCG3tQW639uBZnu+zJLk3tbQBiVH8FlDa9JiCPW
         HRfKWUUnql3QvKUs1jnmNGdy3anDldjBCqIh8bK3rRZYGNKftaFaXoMza2YVvBZSu49w
         mEPw==
X-Gm-Message-State: APjAAAWzHDaepJTSDeiJSTEKShS5jSmVn6RFJ3MNwiOnVsjaI4oNGq03
        RIXH8Zx0ykGa6jrPOlM2xsI//pRsbkti+Hmwibqe5HbEwZk=
X-Google-Smtp-Source: APXvYqxWlaOhpJLHCFVvMiZFAgHSUrXnlwY0Glnic0EmtQ/yIsNdDuAkoahbBQx1lT5MN2/8Hre10UcxIX88goxrTfA=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr17658579plr.262.1561818595593;
 Sat, 29 Jun 2019 07:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 17:29:44 +0300
Message-ID: <CAHp75VfHfpti=yC6RWvz_PPwWXVe+LSSQ0+2rXkXJApPXN+HGg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Intel(R) Speed Select Technology
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Cox <alan@linux.intel.com>, Len Brown <lenb@kernel.org>,
        prarit@redhat.com, darcari@redhat.com,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 1:39 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Intel=C2=AE Speed Select Technology (Intel=C2=AE SST) =E2=80=94 A powerfu=
l new collection of
> features giving more granular control over CPU performance for optimized =
total
> cost of ownership and performance. With Intel=C2=AE SST, one server can b=
e configured
> for power and performance for variety of diverse workload requirements. I=
n the
> Linux submission code. we are using ISST to specify Intel=C2=AE SST to av=
oid confusion
> with existing use of SST for "Smart Sound Technology".
>
> Refer to these links for overview of the technology released with some In=
tel=C2=AE Xeon=C2=AE
> Scalable processor (5218N, 6230N, and 6252N):
> https://www.intel.com/content/www/us/en/architecture-and-technology/speed=
-select-technology-article.html
> https://builders.intel.com/docs/networkbuilders/intel-speed-select-techno=
logy-base-frequency-enhancing-performance.pdf
>
> The next generation of Intel=C2=AE Xeon=C2=AE processors are adding more =
features to the
> Intel=C2=AE Speed Select Technology and allow dynamic configuration of th=
ese features
> from OS-software level instead from BIOS. This submission is adding new f=
eatures
> and dynamic configuration capabilities .
>
>
> Intel SST Features:
>
> Intel=C2=AE SST=E2=80=94Performance Profile (PP or perf-profile):
> This feature allows one server to be configured for different workload re=
quirements
> instead of deploying different servers based on the workload requirement =
reducing total
> cost of ownership. With a single server deployed, the same server can be =
reconfigured
> dynamically to one of the supported profiles to suit the specific workloa=
d requirements.
> This feature introduces a mechanism that allows multiple optimized perfor=
mance profiles
> per system via static and/or dynamic adjustment of TDP level and other pe=
rformance
> parameters.
>
> Intel=C2=AE SST=E2=80=94Core power (CP or core-power):
> An Interface that allows user to define per core priority. This defines a=
 mechanism
> to distribute power among cores when there is a power constrained scenari=
o. This defines
> a class of service configuration. Each CPU core can be tied to a class of=
 service and hence
> an associated priority.
>
> Intel=C2=AE SST=E2=80=94Base Frequency (BF or base-freq):
> The Intel=C2=AE SST-BF feature lets user control and direct base frequenc=
y. If some critical
> workload threads demand constant high guaranteed performance, then this f=
eature can be
> used to execute the thread at higher base frequency on specific set of CP=
Us.
>
> Intel=C2=AE SST=E2=80=94Turbo frequency (TF or turbo-freq):
> Enables the ability to set different all core turbo ratio limits to cores=
 based on the priority.
> Using this features some cores can be configured to get higher turbo freq=
uency by designating
> them as high priority at the cost of lower or no turbo frequency on the l=
ow priority cores.
>
> Implementation
>
> The Intel=C2=AE SST features are implemented in the firmware executing in=
 the the power
> management unit (we are calling PUNIT here for short). The mechanism to c=
ontrol these
> features are specific to firmware implementation for Intel=C2=AE Xeon=C2=
=AE CPUs and are not architectural
> features. The interface mechanism and semantics of the messages can chang=
e in future Xeon
> CPUs. Hence there is minimal kernel implementation by offering direct com=
munication
> to PUNIT via set of IOCTLs. The actual messages which can be sent to PUNI=
T are specified
> in the following document link:
>
> https://github.com/intel/CommsPowerManagement/blob/master/intel_sst_os_in=
terface/mailbox.md
>
> The idea here is that user space software like cloud orchestration softwa=
re based on their workload
> requirement configure the system. There is a full featured "Intel Speed S=
elect" utility
> submitted to kernel power tools, which can be used to validate and exerci=
se the features.
>
> Types of PUNIT interfaces
> There are two types of interfaces. One using Mail box communications, whi=
ch is facilitated
> by a PCI device or in some Xeon=C2=AE CPUs using MSRs; and other using an=
 MMIO interface, which is
> used primarily for core prioritization. For hiding details a single chara=
cter device is created
> to handle IOCTLs. The following block diagram shows the implementation ov=
erview.
>
>
> User            User Space tool(intel-speed-select)/Cloud Orchestration s=
oftware
>                                            IOCTLs
> ---------------------------------------character device------------------=
------------
> kernel                          Common driver handling IOCTLs
>                         Mail Box drivers(PCI & MSR)     PCI MMIO driver
> -------------------------------------------------------------------------=
-
> Hardware                                    PUNIT
>
>
>

Pushed to my review and testing queue, thanks!

> Srinivas Pandruvada (10):
>   platform/x86: ISST: Update ioctl-number.txt for Intel Speed Select
>     interface
>   platform/x86: ISST: Add common API to register and handle ioctls
>   platform/x86: ISST: Store per CPU information
>   platform/x86: ISST: Add IOCTL to Translate Linux logical CPU to PUNIT
>     CPU number
>   platform/x86: ISST: Add Intel Speed Select mmio interface
>   platform/x86: ISST: Add Intel Speed Select mailbox interface via PCI
>   platform/x86: ISST: Add Intel Speed Select mailbox interface via MSRs
>   platform/x86: ISST: Add Intel Speed Select PUNIT MSR interface
>   platform/x86: ISST: Restore state on resume
>   tools/power/x86: A tool to validate Intel Speed Select commands
>
>  Documentation/ioctl/ioctl-number.txt          |    1 +
>  drivers/platform/x86/Kconfig                  |    2 +
>  drivers/platform/x86/Makefile                 |    1 +
>  .../x86/intel_speed_select_if/Kconfig         |   17 +
>  .../x86/intel_speed_select_if/Makefile        |   10 +
>  .../intel_speed_select_if/isst_if_common.c    |  672 +++++++
>  .../intel_speed_select_if/isst_if_common.h    |   69 +
>  .../intel_speed_select_if/isst_if_mbox_msr.c  |  216 +++
>  .../intel_speed_select_if/isst_if_mbox_pci.c  |  214 +++
>  .../x86/intel_speed_select_if/isst_if_mmio.c  |  180 ++
>  include/uapi/linux/isst_if.h                  |  172 ++
>  tools/power/x86/intel_speed_select/Makefile   |   31 +
>  tools/power/x86/intel_speed_select/isst.h     |  231 +++
>  .../x86/intel_speed_select/isst_config.c      | 1607 +++++++++++++++++
>  .../power/x86/intel_speed_select/isst_core.c  |  721 ++++++++
>  .../x86/intel_speed_select/isst_display.c     |  479 +++++
>  16 files changed, 4623 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/Kconfig
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/Makefile
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_co=
mmon.c
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_co=
mmon.h
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mb=
ox_msr.c
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mb=
ox_pci.c
>  create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mm=
io.c
>  create mode 100644 include/uapi/linux/isst_if.h
>  create mode 100644 tools/power/x86/intel_speed_select/Makefile
>  create mode 100644 tools/power/x86/intel_speed_select/isst.h
>  create mode 100644 tools/power/x86/intel_speed_select/isst_config.c
>  create mode 100644 tools/power/x86/intel_speed_select/isst_core.c
>  create mode 100644 tools/power/x86/intel_speed_select/isst_display.c
>
> --
> 2.17.2
>


--=20
With Best Regards,
Andy Shevchenko

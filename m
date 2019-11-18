Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C611C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CAE20726
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoeQXYAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRKwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:52:51 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45380 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:52:51 -0500
Received: by mail-pg1-f173.google.com with SMTP id k1so8151565pgg.12;
        Mon, 18 Nov 2019 02:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QRAXXNuaX1ulYv3yRwsv1d9uwNkpzG900/tupa5mGak=;
        b=KoeQXYAFi1Vrfw5h//PFTKOd2NBnfj12px08B5mnfxbS4XCNJUtwjwfaZutEYeqz6V
         pInI636Prg0ODmMddb9b4rYirH5+CC79LrFe4AKf94O314CLeWvvk6FmDo2iFeBuvczn
         IbUJ1qoMQVPYIw1svIbemI6YxdqeA2NVVx9HniatvkiKQhx4S2/4ioOCZBu2VNlDlYWY
         bexg1G6diC4lIrwtpQlNd/uyBYHIR2DqIwS8e+JBHtqP3Y6Gxoz5F7sjL1VXSOm9KmQV
         nN8bDjfkgVBpyWvvEQshSwKZQq5uNv8/hWrGpjcslKod1g8DgdZd/Rs8gs9jELx8kcAX
         vx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QRAXXNuaX1ulYv3yRwsv1d9uwNkpzG900/tupa5mGak=;
        b=Vsdx0ekQh3p9qQk/W8yAXGFurFSphsuxiwOSOfBfn3V9HHlIEi7FN/IYloIAy76TZw
         Ego/3rcXNY3og9dNjSxx1RDzm9uaSA8xuhyAeXcu4F0MR9AxSXYgKGLCRVt2qy7aPJ6R
         ywxOLdzKxASl4BFArkGH4vrgZszfkTA/jilBvFJiXnQtWkq/po2d6je7r1k3015VjTeo
         bWv2BEmaDBRezmhX1VImC9p1/q6eJPhasM3FQLGCtyd0s6izHk4aKSWWwC+bo5zTlIaM
         GXQvbAEB4d3VnME3oPzl9Nwm0NJaQixEhpMhaC2SVZAam5pcqJdYSkK5XfgzwuuikK4H
         bj7g==
X-Gm-Message-State: APjAAAW8pD6H/FO8C6+JtAOrKjB9IZ78uITLtrNsJ2vb+4wEofdgvj7F
        OaVeJud9NVHvaeJ+CBs2tDZMgHM7XS+Bt9bUXUI=
X-Google-Smtp-Source: APXvYqzbTHjh8hcyBhL9duTVNR96E2KE+BRPISI0+I54Y3WW+ztui1i8ZMpx4CowSzDoA6Cd9VI/v1Q/sqDI6yPStNE=
X-Received: by 2002:a62:1ad6:: with SMTP id a205mr33181056pfa.64.1574074368380;
 Mon, 18 Nov 2019 02:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20191115204925.55181-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20191115204925.55181-1-srinivas.pandruvada@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Nov 2019 12:52:38 +0200
Message-ID: <CAHp75VdtmDQOqFty2T317VXjDHxRztAh8EE4Xko3faEhc_i+hg@mail.gmail.com>
Subject: Re: [PATCH] admin guide/pm: Admin guide for intel-speed-select
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Prarit Bhargava <prarit@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.co>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:51 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Added documentation to configure servers to use Intel(R) Speed
> Select Technology using intel-speed-select tool.
>

Acked-by: Andriy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../admin-guide/pm/intel-speed-select.rst     | 934 ++++++++++++++++++
>  .../admin-guide/pm/working-state.rst          |   1 +
>  2 files changed, 935 insertions(+)
>  create mode 100644 Documentation/admin-guide/pm/intel-speed-select.rst
>
> diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Docume=
ntation/admin-guide/pm/intel-speed-select.rst
> new file mode 100644
> index 000000000000..c2ce57ebc268
> --- /dev/null
> +++ b/Documentation/admin-guide/pm/intel-speed-select.rst
> @@ -0,0 +1,934 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Intel=C2=AE Speed Select Technology (Intel=C2=AE SST) : User Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Intel=C2=AE Speed Select Technology (Intel=C2=AE SST) provides a pow=
erful new
> +collection of features that give more granular control over CPU performa=
nce.
> +With Intel=C2=AE SST, one server can be configured for power and perform=
ance for a
> +variety of diverse workload requirements.
> +
> +Refer to the links below for an overview of the technology:
> +
> +- https://www.intel.com/content/www/us/en/architecture-and-technology/sp=
eed-select-technology-article.html
> +- https://builders.intel.com/docs/networkbuilders/intel-speed-select-tec=
hnology-base-frequency-enhancing-performance.pdf
> +
> +These capabilities are further enhanced in some of the newer generations=
 of
> +server platforms where these features can be enumerated and controlled
> +dynamically without pre-configuring via BIOS setup options. This dynamic
> +configuration is done via mailbox commands to the hardware. One way to e=
numerate
> +and configure these features is by using the Intel=C2=AE Speed Select ut=
ility.
> +
> +This document explains how to use the Intel=C2=AE Speed Select tool to e=
numerate and
> +control Intel=C2=AE SST features. This document gives example commands a=
nd explains
> +how these commands change the power and performance profile of the syste=
m under
> +test. Using this tool as an example, customers can replicate the messagi=
ng
> +implemented in the tool in their production software.
> +
> +
> +intel-speed-select configuration tool
> +-------------------------------------
> +Most Linux distribution packages include the "intel-speed-select" tool. =
If not,
> +it can be built by downloading the Linux kernel tree from kernel.org. On=
ce
> +downloaded, the tool can be built without building the full kernel.
> +
> +From the kernel tree, run the following commands:
> +
> +# cd tools/power/x86/intel-speed-select/
> +
> +# make
> +
> +# make install
> +
> +**Getting Help**
> +
> +To get help with the tool, execute the command below:
> +
> +#intel-speed-select --help
> +
> +The top-level help describes arguments and features. Notice that there i=
s a
> +multi-level help structure in the tool. For example:
> +
> +#intel-speed-select perf-profile --help
> +
> +This brings help for the feature "perf-profile"
> +
> +#intel-speed-select perf-profile info --help
> +
> +This brings help for the command "info".
> +
> +
> +Intel=C2=AE Speed Select Technology - Performance Profile (Intel=C2=AE S=
ST-PP)
> +----------------------------------------
> +
> +This feature allows configuration of a server dynamically based on workl=
oad
> +performance requirements. This helps users during deployment as they do =
not have
> +to choose a specific server configuration statically.  This Intel=C2=AE =
Speed Select
> +Technology - Performance Profile (Intel=C2=AE SST-PP) feature introduces=
 a mechanism
> +that allows multiple optimized performance profiles per system. Each pro=
file
> +defines a set of CPUs that need to be online and rest offline to sustain=
 a
> +guaranteed base frequency. Once the user issues a command to use a speci=
fic
> +performance profile and meet CPU online/offline requirement, the user ca=
n expect
> +a change in the base frequency dynamically. This feature is called
> +"perf-profile" when using the Intel=C2=AE Speed Select tool.
> +
> +**Number or performance levels**
> +
> +There can be multiple performance profiles on a system. To get the numbe=
r of
> +profiles, execute the command below:
> +
> +#intel-speed-select perf-profile get-config-levels
> + package-0
> +  die-0
> +    cpu-0
> +        get-config-levels:4
> + package-1
> +  die-0
> +    cpu-14
> +        get-config-levels:4
> +
> +On this system under test, there are 4 performance profiles in addition =
to the
> +base performance profile (which is performance level 0).
> +
> +**Lock/Unlock status**
> +
> +Even if there are multiple performance profiles, it is possible that tha=
t they
> +are locked. If they are locked, users cannot issue a command to change t=
he
> +performance state. It is possible that there is a BIOS setup to unlock o=
r check
> +with your system vendor.
> +
> +To check if the system is locked, execute the following command:
> +
> +#intel-speed-select perf-profile get-lock-status
> + package-0
> +  die-0
> +    cpu-0
> +        get-lock-status:0
> + package-1
> +  die-0
> +    cpu-14
> +        get-lock-status:0
> +
> +In this case, lock status is 0, which means that the system is unlocked.
> +
> +**Properties of a performance level**
> +
> +To get properties of a specific performance level (For example for the l=
evel 0, below), execute the command below:
> +
> +#intel-speed-select perf-profile info -l 0
> + package-0
> +  die-0
> +    cpu-0
> +      perf-profile-level-0
> +        cpu-count:28
> +
> +        enable-cpu-mask:000003ff,f0003fff
> +
> +        enable-cpu-list:0,1,2,3,4,5,6,7,8,9,10,11,12,13,28,29,30,31,32,3=
3,34,35,36,37,38,39,40,41
> +
> +        thermal-design-power-ratio:26
> +
> +        base-frequency(MHz):2600
> +
> +        speed-select-turbo-freq:disabled
> +
> +        speed-select-base-freq:disabled
> +       ...
> +       ...
> +
> +Here -l option is used to specify a performance level.
> +
> +If the option -l is omitted, then this command will print information ab=
out all
> +the performance levels. The above command is printing properties of the
> +performance level 0.
> +
> +For this performance profile, the list of CPUs displayed by the
> +"enable-cpu-mask/enable-cpu-list" at the max can be "online." When that
> +condition is met, then base frequency of 2600 MHz can be maintained. To
> +understand more, execute "intel-speed-select perf-profile info" for perf=
ormance
> +level 4.
> +
> +#intel-speed-select perf-profile info -l 4
> + package-0
> +  die-0
> +    cpu-0
> +      perf-profile-level-4
> +        cpu-count:28
> +
> +        enable-cpu-mask:000000fa,f0000faf
> +
> +        enable-cpu-list:0,1,2,3,5,7,8,9,10,11,28,29,30,31,33,35,36,37,38=
,39
> +
> +        thermal-design-power-ratio:28
> +
> +        base-frequency(MHz):2800
> +
> +        speed-select-turbo-freq:disabled
> +
> +        speed-select-base-freq:unsupported
> +       ...
> +       ...
> +
> +There are fewer CPUs in the =E2=80=9Cenable-cpu-mask/enable-cpu-list.=E2=
=80=9D Consequently, if
> +the user only keeps these CPUs online and the rest "offline," then the b=
ase
> +frequency is increased to 2.8 GHz compared to 2.6 GHz at performance lev=
el 0.
> +
> +**Get current performance level**
> +
> +To get the current performance level, execute:
> +
> +# intel-speed-select perf-profile get-config-current-level
> + package-0
> +  die-0
> +    cpu-0
> +        get-config-current_level:0
> +
> +First verify that the base_frequency displayed by the cpufreq sysfs is c=
orrect:
> +
> +# cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency
> +
> +2600000
> +
> +This matches the base-frequency (MHz) field value displayed from the
> +"perf-profile info" command for performance level 0(cpufreq frequency is=
 in
> +KHz).
> +
> +To check if the average frequency is equal to the base frequency for a 1=
00% busy
> +workload, disable turbo:
> +
> +# echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> +
> +Then runs a busy workload on all CPUs, for example:
> +
> +#stress -c 64
> +
> +To verify the base frequency, run turbostat:
> +
> +#turbostat -c 0-13 --show Package,Core,CPU,Bzy_MHz -i 1
> +
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D   =3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Package        Core    CPU     Bzy_MHz
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D   =3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +       -       -       2600
> +0      0       0       2600
> +0      1       1       2600
> +0      2       2       2600
> +0      3       3       2600
> +0      4       4       2600
> +.       .       .       .
> +.       .       .       .
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D   =3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +**Changing performance level**
> +
> +To the change the performance level to 4, execute:
> +
> +#intel-speed-select -d perf-profile set-config-level -l 4 -o
> + package-0
> +  die-0
> +    cpu-0
> +      perf-profile
> +        set_tdp_level:success
> +
> +In the command above, "-o" is optional. If it is specified, then it will=
 also
> +offline CPUs which are not present in the enable_cpu_mask for this perfo=
rmance
> +level.
> +
> +Now if the base_frequency is checked:
> +
> +#cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency
> +
> +2800000
> +
> +Which shows that the base frequency now increased from 2600 MHz at perfo=
rmance
> +level 0 to 2800 MHz at performance level 4. As a result, any workload, w=
hich can
> +use fewer CPUs, can see a boost of 200 MHz compared to performance level=
 0.
> +
> +**Check presence of other Intel=C2=AE SST features**
> +
> +Each of the performance profiles also specifies weather there is support=
 of
> +other two Intel=C2=AE SST features (Intel=C2=AE Speed Select Technology =
- Base Frequency
> +(Intel=C2=AE SST-BF) and Intel=C2=AE Speed Select Technology - Turbo Fre=
quency (Intel=C2=AE
> +SST-TF)).
> +
> +For example, from the output of "perf-profile info" above, for level 0 a=
nd level
> +4:
> +
> +For level 0:
> +       speed-select-turbo-freq:disabled
> +
> +       speed-select-base-freq:disabled
> +
> +For level 4:
> +
> +       speed-select-turbo-freq:disabled
> +
> +       speed-select-base-freq:unsupported
> +
> +Given these results, the =E2=80=9Cspeed-select-base-freq=E2=80=9D (Intel=
=C2=AE SST-BF) in level 4
> +changed from "disabled" to "unsupported" compared to performance level 0=
.
> +
> +This means that at performance level 4, the "speed-select-base-freq" fea=
ture is
> +not supported. However, at performance level 0, this feature is "support=
ed", but
> +currently "disabled", meaning the user has not activated this feature. W=
hereas
> +"speed-select-turbo-freq" (Intel=C2=AE SST-TF) is supported at both perf=
ormance
> +levels, but currently not activated by the user.
> +
> +The Intel=C2=AE SST-BF and the Intel=C2=AE SST-TF features are built on =
a foundation
> +technology called Intel=C2=AE Speed Select Technology - Core Power (Inte=
l=C2=AE SST-CP).
> +The platform firmware enables this feature when Intel=C2=AE SST-BF or In=
tel=C2=AE SST-TF
> +is supported on a platform.
> +
> +Intel=C2=AE Speed Select Technology =E2=80=93 Core Power (Intel=C2=AE SS=
T-CP)
> +----------------------------------------
> +
> +Intel=C2=AE Speed Select Technology =E2=80=93 Core Power (Intel=C2=AE SS=
T-CP) is an interface that
> +allows users to define per core priority. This defines a mechanism to di=
stribute
> +power among cores when there is a power constrained scenario. This defin=
es a
> +class of service (CLOS) configuration.
> +
> +The user can configure up to 4 class of service configurations. Each CLO=
S group
> +configuration allows definitions of parameters, which affects how the fr=
equency
> +can be limited and power is distributed. Each CPU core can be tied to a =
class of
> +service and hence an associated priority. The granularity is at core lev=
el not
> +at per CPU level.
> +
> +**Enable CLOS based prioritization**
> +
> +To use CLOS based prioritization feature, firmware must be informed to e=
nable
> +and use a priority type. There is a default per platform priority type, =
which
> +can be changed with optional command line parameter.
> +
> +To enable and check the options, execute:
> +
> +# intel-speed-select core-power enable --help
> +
> +Intel(R) Speed Select Technology
> +
> +Enable core-power for a package/die
> +       Clos Enable: Specify priority type with [--priority|-p]
> +                0: Proportional, 1: Ordered
> +
> +There are two types of priority types:
> +
> +- Ordered
> +Priority for ordered throttling is defined based on the index of the ass=
igned
> +CLOS group. Where CLOS0 gets highest priority (throttled last).
> +
> +Priority order is:
> +CLOS0 > CLOS1 > CLOS2 > CLOS3.
> +
> +- Proportional
> +When proportional priority is used, there is an additional parameter cal=
led
> +frequency_weight, which can be specified per CLOS group. The goal of
> +proportional priority is to provide each core with the requested min., t=
hen
> +distribute all remaining (excess/deficit) budgets in proportion to a def=
ined
> +weight. This proportional priority can be configured using "core-power c=
onfig"
> +command.
> +
> +To enable with the platform default priority type, execute:
> +
> +# intel-speed-select core-power enable
> + package-0
> +  die-0
> +    cpu-0
> +      core-power
> +        enable:success
> + package-1
> +  die-0
> +    cpu-6
> +      core-power
> +        enable:success
> +
> +The scope of this enable is per package or die scoped when a package con=
tains
> +multiple dies. To check if CLOS is enabled and get priority type, "core-=
power
> +info" command can be used. For example to check the status of core-power=
 feature
> +on CPU 0, execute:
> +
> +#intel-speed-select -c 0 core-power info
> + package-0
> +  die-0
> +    cpu-0
> +      core-power
> +        enable-status:1
> +        priority-type:0
> +
> +
> +**Configuring CLOS groups**
> +
> +Each CLOS group has its own attributes including min, max, freq_weight a=
nd
> +desired. These parameters can be configured with "core-power config" com=
mand.
> +Defaults will be used if user skips setting a parameter except clos id, =
which is
> +mandatory.
> +
> +#intel-speed-select core-power config --help
> +
> +Intel(R) Speed Select Technology
> +
> +Set core-power configuration for one of the four clos ids
> +       Specify targeted clos id with [--clos|-c]
> +
> +       Specify clos Proportional Priority [--weight|-w]
> +
> +       Specify clos min in MHz with [--min|-n]
> +
> +       Specify clos max in MHz with [--max|-m]
> +
> +       Specify clos desired in MHz with [--desired|-d]
> +
> +For example:
> +#intel-speed-select core-power config -c 0
> +
> +Intel(R) Speed Select Technology
> +
> +clos epp is not specified, default: 0
> +
> +clos frequency weight is not specified, default: 0
> +
> +clos min is not specified, default: 0 MHz
> +
> +clos max is not specified, default: 25500 MHz
> +
> +clos desired is not specified, default: 0
> + package-0
> +  die-0
> +    cpu-0
> +      core-power
> +        config:success
> + package-1
> +  die-0
> +    cpu-6
> +      core-power
> +        config:success
> +
> +The user has the option to change defaults. For example, the user can ch=
ange the
> +"min" and set the base frequency to always get guaranteed base frequency=
.
> +
> +**Get the current CLOS configuration**
> +
> +To check the current configuration, "core-power get-config" can be used.=
 For
> +example, to get the configuration of CLOS 0:
> +
> +#intel-speed-select core-power get-config -c 0
> + package-0
> +  die-0
> +    cpu-0
> +      core-power
> +
> +        clos:0
> +
> +        epp:0
> +
> +        clos-proportional-priority:0
> +
> +        clos-min:0 MHz
> +
> +        clos-max:25500 MHz
> +
> +        clos-desired:0
> +
> + package-1
> +  die-0
> +    cpu-6
> +      core-power
> +        clos:0
> +
> +        epp:0
> +
> +        clos-proportional-priority:0
> +
> +        clos-min:0 MHz
> +
> +        clos-max:25500 MHz
> +
> +        clos-desired:0
> +
> +**Associating a CPU with a CLOS group**
> +
> +To associate a CPU to a CLOS group "core-power assoc" command can be use=
d.
> +
> +# intel-speed-select core-power assoc --help
> +Associate a clos id to a CPU
> +       Specify targeted clos id with [--clos|-c]
> +
> +
> +For example to associate CPU 10 to CLOS group 3, execute:
> +
> +#intel-speed-select -c 10 core-power assoc -c 3
> + package-1
> +  die-0
> +    cpu-10
> +      core-power
> +        assoc:success
> +
> +Once a CPU is associated, its sibling CPUs are also associated to a CLOS=
 group.
> +Once associated, avoid changing Linux =E2=80=9Ccpufreq=E2=80=9D subsyste=
m scaling frequency
> +limits.
> +
> +To check the existing association for a CPU, "core-power get-assoc" comm=
and can
> +be used. For example, to get association of CPU 10, execute:
> +
> +#intel-speed-select -c 10 core-power get-assoc
> + package-1
> +  die-0
> +    cpu-10
> +      get-assoc
> +        clos:3
> +
> +This shows that CPU 10 is part of a CLOS group 3.
> +
> +
> +**Disable CLOS based prioritization**
> +
> +To disable, execute:
> +
> +# intel-speed-select core-power disable
> +
> +Some features like Intel=C2=AE SST-TF can only be enabled when CLOS base=
d prioritization
> +is enabled. For this reason, disabling while Intel=C2=AE SST-TF is enabl=
ed can cause
> +Intel=C2=AE SST-TF to fail. This will cause the "disable" command to dis=
play an error
> +if Intel=C2=AE SST-TF is already enabled. In turn, to disable, the Intel=
=C2=AE SST-TF
> +feature must be disabled first.
> +
> +Intel=C2=AE Speed Select Technology - Base Frequency (Intel=C2=AE SST-BF=
)
> +----------------------------------
> +
> +The Intel=C2=AE Speed Select Technology - Base Frequency (Intel=C2=AE SS=
T-BF) feature lets
> +the user control base frequency. If some critical workload threads deman=
d
> +constant high guaranteed performance, then this feature can be used to e=
xecute
> +the thread at higher base frequency on specific sets of CPUs (high prior=
ity
> +CPUs) at the cost of lower base frequency (low priority CPUs) on other C=
PUs.
> +This feature does not require offline of the low priority CPUs.
> +
> +The support of Intel=C2=AE SST-BF depends on the Intel=C2=AE Speed Selec=
t Technology -
> +Performance Profile (Intel=C2=AE SST-PP) performance level configuration=
. It is
> +possible that only certain performance levels support Intel=C2=AE SST-BF=
. It is also
> +possible that only base performance level (level =3D 0) has support of I=
ntel=C2=AE
> +SST-BF. Consequently, first select the desired performance level to enab=
le this
> +feature.
> +
> +In the system under test here, Intel=C2=AE SST-BF is supported at the ba=
se
> +performance level 0, but currently disabled.
> +
> +#intel-speed-select -c 0 perf-profile info -l 0
> + package-0
> +  die-0
> +    cpu-0
> +      perf-profile-level-0
> +        ...
> +        ...
> +        speed-select-base-freq:disabled
> +
> +       ...
> +       ...
> +
> +Before enabling Intel=C2=AE SST-BF and measuring its impact on a workloa=
d
> +performance, execute some workload and measure performance and get a bas=
eline
> +performance to compare against.
> +
> +Here the user wants more guaranteed performance. For this reason, it is =
likely
> +that turbo is disabled. To disable turbo, execute:
> +
> +#echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> +
> +Based on the output of the "intel-speed-select perf-profile info -l 0" b=
ase
> +frequency of guaranteed frequency 2600 MHz.
> +
> +
> +**Measure baseline performance for comparison**
> +
> +To compare, pick a multi-threaded workload where each thread can be sche=
duled on
> +separate CPUs. "Hackbench pipe" test is a good example on how to improve
> +performance using Intel=C2=AE SST-BF.
> +
> +Below, the workload is measuring average scheduler wakeup latency, so a =
lower
> +number means better performance:
> +
> +# taskset -c 3,4 perf bench -r 100 sched pipe
> +
> +# Running 'sched/pipe' benchmark:
> +
> +# Executed 1000000 pipe operations between two processes
> +
> +     Total time: 6.102 [sec]
> +
> +       6.102445 usecs/op
> +
> +         163868 ops/sec
> +
> +While running the above test, if we take turbostat output, it will show =
us that
> +2 of the CPUs are busy and reaching max. frequency (which would be the b=
ase
> +frequency as the turbo is disabled).
> +
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +Package        Core    CPU     Bzy_MHz
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +0      0       0       1000
> +0      1       1       1005
> +0      2       2       1000
> +0      3       3       2600
> +0      4       4       2600
> +0      5       5       1000
> +0      6       6       1000
> +0      7       7       1005
> +0      8       8       1005
> +0      9       9       1000
> +0      10      10      1000
> +0      11      11      995
> +0      12      12      1000
> +0      13      13      1000
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +
> +From the above turbostat output, both CPU 3 and 4 are very busy and reac=
hing
> +full guaranteed frequency of 2600 MHz.
> +
> +**Intel=C2=AE SST-BF Capabilities**
> +
> +To get capabilities of Intel=C2=AE SST-BF for the current performance le=
vel 0,
> +execute:
> +
> +#intel-speed-select base-freq info -l 0
> + package-0
> +  die-0
> +    cpu-0
> +      speed-select-base-freq
> +        high-priority-base-frequency(MHz):3000
> +
> +        high-priority-cpu-mask:00000216,00002160
> +
> +        high-priority-cpu-list:5,6,8,13,33,34,36,41
> +
> +        low-priority-base-frequency(MHz):2400
> +
> +        tjunction-temperature(C):125
> +
> +        thermal-design-power(W):205
> +
> +The above capabilities show that there are some CPUs on this system that=
 can
> +offer base frequency of 3000 MHz compared to the standard base frequency=
 at this
> +performance levels. Nevertheless, these CPUs are fixed, and they are pre=
sented
> +via high-priority-cpu-list/high-priority-cpu-mask. But if this Intel=C2=
=AE SST-BF
> +feature is selected, the low priorities CPUs (which are not in
> +high-priority-cpu-list) can only offer up to 2400 MHz. As a result, if t=
his
> +clipping of low priority CPUs is acceptable, then the user can enable In=
tel=C2=AE
> +SST-BF feature particularly for the above "sched pipe" workload since on=
ly two
> +CPUs are used, they can be scheduled on high priority CPUs and can get b=
oost of
> +400 MHz.
> +
> +**Enable Intel=C2=AE SST-BF**
> +
> +To enable Intel=C2=AE SST-BF feature, execute:
> +
> +#intel-speed-select base-freq enable -a
> + package-0
> +  die-0
> +    cpu-0
> +      base-freq
> +        enable:success
> + package-1
> +  die-0
> +    cpu-14
> +      base-freq
> +        enable:success
> +
> +In this case, -a option is optional. This not only enables Intel=C2=AE S=
ST-BF, but it
> +also adjusts the priority of cores using Intel=C2=AE Speed Select Techno=
logy =E2=80=93 Core
> +Power (Intel=C2=AE SST-CP) features. This option sets the minimum perfor=
mance of each
> +Intel=C2=AE Speed Select Technology - Performance Profile (Intel=C2=AE S=
ST-PP) class to
> +maximum performance so that the hardware will give maximum performance p=
ossible
> +for each CPU.
> +
> +If -a option is not used, then the following steps are required before e=
nabling
> +Intel=C2=AE SST-BF:
> +
> +- Discover Intel=C2=AE SST-BF and note low and high priority base freque=
ncy
> +- Note the high prioity CPU list
> +- Enable CLOS using core-power feature set
> +- Configure CLOS parameters. Use CLOS.min to set to minimum performance
> +- Subscribe desired CPUs to CLOS groups
> +
> +With this configuration, if the same workload is executed by pinning the
> +workload to high priority CPUs (CPU 5 and 6 in this case):
> +
> +#taskset -c 5,6 perf bench -r 100 sched pipe
> +
> +# Running 'sched/pipe' benchmark:
> +
> +# Executed 1000000 pipe operations between two processes
> +
> +     Total time: 5.627 [sec]
> +
> +       5.627922 usecs/op
> +         177685 ops/sec
> +
> +This way, by enabling Intel=C2=AE SST-BF, the performance of this benchm=
ark is
> +improved (latency reduced) by 7.79%. From the turbostat output, it can b=
e
> +observed that the high priority CPUs reached 3000 MHz compared to 2600 M=
Hz.
> +
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +Package        Core    CPU     Bzy_MHz
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +0      0       0       2151
> +0      1       1       2166
> +0      2       2       2175
> +0      3       3       2175
> +0      4       4       2175
> +0      5       5       3000
> +0      6       6       3000
> +0      7       7       2180
> +0      8       8       2662
> +0      9       9       2176
> +0      10      10      2175
> +0      11      11      2176
> +0      12      12      2176
> +0      13      13      2661
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +
> +**Disable Intel=C2=AE SST-BF**
> +
> +To disable the Intel=C2=AE SST-BF feature, execute:
> +
> +#intel-speed-select base-freq disable -a
> +
> +
> +Intel=C2=AE Speed Select Technology - Turbo Frequency (Intel=C2=AE SST-T=
F)
> +------------------------------------
> +
> +This feature enables the ability to set different "All core turbo ratio =
limits"
> +to cores based on the priority. By using this feature, some cores can be
> +configured to get higher turbo frequency by designating them as high pri=
ority at
> +the cost of lower or no turbo frequency on the low priority cores.
> +
> +For this reason, this feature is only useful when system is busy utilizi=
ng all
> +CPUs, but the user wants some configurable option to get high performanc=
e on
> +some CPUs.
> +
> +The support of Intel=C2=AE Speed Select Technology - Turbo Frequency (In=
tel=C2=AE SST-TF)
> +depends on the Intel=C2=AE Speed Select Technology - Performance Profile=
 (Intel=C2=AE
> +SST-PP) performance level configuration. It is possible that only a cert=
ain
> +performance level supports Intel=C2=AE SST-TF. It is also possible that =
only the base
> +performance level (level =3D 0) has the support of Intel=C2=AE SST-TF. H=
ence, first
> +select the desired performance level to enable this feature.
> +
> +In the system under test here, Intel=C2=AE SST-TF is supported at the ba=
se
> +performance level 0, but currently disabled.
> +
> +#intel-speed-select -c 0 perf-profile info -l 0
> + package-0
> +  die-0
> +    cpu-0
> +      perf-profile-level-0
> +        ...
> +        ...
> +        speed-select-turbo-freq:disabled
> +
> +       ...
> +       ...
> +
> +
> +To check if performance can be improved using Intel=C2=AE SST-TF feature=
, get the turbo
> +frequency properties with Intel=C2=AE SST-TF enabled and compare to the =
base turbo
> +capability of this system.
> +
> +**Get Base turbo capability**
> +
> +To get the base turbo capability of performance level 0, execute:
> +
> +#intel-speed-select perf-profile info -l 0
> + package-0
> +  die-0
> +    cpu-0
> +      perf-profile-level-0
> +
> +        ...
> +
> +        ...
> +
> +        turbo-ratio-limits-sse
> +          bucket-0
> +            core-count:2
> +
> +            max-turbo-frequency(MHz):3200
> +
> +          bucket-1
> +            core-count:4
> +
> +            max-turbo-frequency(MHz):3100
> +          bucket-2
> +            core-count:6
> +
> +            max-turbo-frequency(MHz):3100
> +          bucket-3
> +            core-count:8
> +
> +            max-turbo-frequency(MHz):3100
> +          bucket-4
> +            core-count:10
> +
> +            max-turbo-frequency(MHz):3100
> +          bucket-5
> +            core-count:12
> +
> +            max-turbo-frequency(MHz):3100
> +          bucket-6
> +            core-count:14
> +
> +            max-turbo-frequency(MHz):3100
> +          bucket-7
> +            core-count:16
> +
> +            max-turbo-frequency(MHz):3100
> +
> +Based on the data above, when all the CPUS are busy, the max. frequency =
of 3100
> +MHz can be achieved. If there is some busy workload on cpu 0 - 11 (e.g. =
stress)
> +and on CPU 12 and 13, execute "hackbench pipe" workload:
> +
> +# taskset -c 12,13 perf bench -r 100 sched pipe
> +
> +# Running 'sched/pipe' benchmark:
> +
> +# Executed 1000000 pipe operations between two processes
> +
> +     Total time: 5.705 [sec]
> +
> +       5.705488 usecs/op
> +         175269 ops/sec
> +
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +Package        Core    CPU     Bzy_MHz
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +0      0       0       3000
> +0      1       1       3000
> +0      2       2       3000
> +0      3       3       3000
> +0      4       4       3000
> +0      5       5       3100
> +0      6       6       3100
> +0      7       7       3000
> +0      8       8       3100
> +0      9       9       3000
> +0      10      10      3000
> +0      11      11      3000
> +0      12      12      3100
> +0      13      13      3100
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +
> +Based on turbostat output, the performance is limited by frequency cap o=
f 3100
> +MHz. To check if the hackbench performance can be improved for CPU 12 an=
d CPU
> +13, first check the capability of the Intel=C2=AE SST-TF feature for thi=
s performance
> +level.
> +
> +**Get Intel=C2=AE SST-TF Capability**
> +
> +To get the capability, the "turbo-freq info" command can be used:
> +
> +#intel-speed-select turbo-freq info -l 0
> +      speed-select-turbo-freq
> +          bucket-0
> +            high-priority-cores-count:2
> +
> +            high-priority-max-frequency(MHz):3200
> +
> +            high-priority-max-avx2-frequency(MHz):3200
> +
> +            high-priority-max-avx512-frequency(MHz):3100
> +
> +          bucket-1
> +            high-priority-cores-count:4
> +
> +            high-priority-max-frequency(MHz):3100
> +
> +            high-priority-max-avx2-frequency(MHz):3000
> +
> +            high-priority-max-avx512-frequency(MHz):2900
> +
> +          bucket-2
> +            high-priority-cores-count:6
> +
> +            high-priority-max-frequency(MHz):3100
> +
> +            high-priority-max-avx2-frequency(MHz):3000
> +
> +            high-priority-max-avx512-frequency(MHz):2900
> +
> +          speed-select-turbo-freq-clip-frequencies
> +            low-priority-max-frequency(MHz):2600
> +
> +            low-priority-max-avx2-frequency(MHz):2400
> +
> +            low-priority-max-avx512-frequency(MHz):2100
> +
> +Based on the output above, there is an Intel=C2=AE SST-TF bucket for whi=
ch there are
> +two high priority cores. If only two high priority cores are set, then m=
ax.
> +turbo frequency on those cores can be increased to 3200 MHz. This is 100=
 MHz
> +more than the base turbo capability for all cores.
> +
> +In turn, for the hackbench workload, two CPUs can be set as high priorit=
y and
> +rest as low priority. One side effect is that once enabled, the low prio=
rity
> +cores will be clipped to a lower frequency of 2600 MHz.
> +
> +**Enable Intel=C2=AE SST-TF**
> +
> +To enable Intel=C2=AE SST-TF, execute:
> +
> +#intel-speed-select -c 12,13 turbo-freq enable -a
> +
> +Intel(R) Speed Select Technology
> + package-0
> +  die-0
> +    cpu-12
> +      turbo-freq
> +        enable:success
> + package-0
> +  die-0
> +    cpu-13
> +      turbo-freq
> +        enable:success
> +
> + package--1
> +  die-0
> +    cpu-63
> +      turbo-freq --auto
> +        enable:success
> +
> +In this case, the option "-a" is optional. If set, it enables Intel=C2=
=AE SST-TF
> +feature and also sets the CPUs to high and and low priority using Intel=
=C2=AE Speed
> +Select Technology =E2=80=93 Core Power (Intel=C2=AE SST-CP) features. Th=
e CPU numbers passed
> +with "-c" arguments are marked as high priority, including its siblings.
> +
> +If -a option is not used, then the following steps are required before e=
nabling
> +Intel=C2=AE SST-TF:
> +
> +- Discover Intel=C2=AE SST-TF and note buckets of high priority cores an=
d maximum
> +frequency
> +
> +- Enable CLOS using core-power feature set - Configure CLOS parameters
> +
> +- Subscribe desired CPUs to CLOS groups making sure that high priority c=
ores are set to the maximum frequency
> +
> +If the same hackbench workload is executed, schedule hackbench threads o=
n high
> +priority CPUs:
> +
> +#taskset -c 12,13 perf bench -r 100 sched pipe
> +
> +# Running 'sched/pipe' benchmark:
> +
> +# Executed 1000000 pipe operations between two processes
> +
> +     Total time: 5.510 [sec]
> +
> +       5.510165 usecs/op
> +         180826 ops/sec
> +
> +This improved performance by around 3.3% improvement on a busy system. H=
ere the
> +turbostat output will show that the CPU 12 and CPU 13 are getting 100 MH=
z boost.
> +
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +Package        Core    CPU     Bzy_MHz
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> +...
> +0      12      12      3200
> +0      13      13      3200
> +
> +=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D    =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=
=3D
> diff --git a/Documentation/admin-guide/pm/working-state.rst b/Documentati=
on/admin-guide/pm/working-state.rst
> index fc298eb1234b..06d1403b1597 100644
> --- a/Documentation/admin-guide/pm/working-state.rst
> +++ b/Documentation/admin-guide/pm/working-state.rst
> @@ -11,3 +11,4 @@ Working-State Power Management
>     cpufreq
>     intel_pstate
>     intel_epb
> +   intel-speed-select
> --
> 2.17.2
>


--=20
With Best Regards,
Andy Shevchenko

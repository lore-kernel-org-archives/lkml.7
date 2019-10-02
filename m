Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8104AC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A2220881
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 23:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC03QT6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfJBX7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 19:59:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39099 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfJBX7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:59:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so606274plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RS1NKRZI2juygWRn07bX62Gsi/9ry5hM13rNr3yhTRg=;
        b=CC03QT6IzPdPm1zcLjDcBIxxGWzK9zNP9Tm2qA9VcvbJW3QeNQZlTT8SQ8VCGFn4aN
         ESsNJ/tLf8SUTOy4Ili6w2Wj2Bry4Q4kxQO7p3TYTw7DDdJO/V5yBptCRLkjB3NapvRh
         u7L3dub0sMCAMryI4Jq3PrZuZcZsjA7d05kVoSZt5s++WUgUXceHGJIXScPvZMDeuwtK
         r2LxFJpLWJNDRCTFlR0Ib4qpmN4gcwKwAzZMllxAZOrvHMPturJMJDteF4TCEzyGlWr1
         X8lfwICZnBauNEVMR7f1t97DhFTgcuVLiQ2yvJzQ4FvR+qmFotkMWSRERQixcrAlgLhK
         +XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RS1NKRZI2juygWRn07bX62Gsi/9ry5hM13rNr3yhTRg=;
        b=KSX3zG9jF0gqeB24qRUnqhLrMpibAWRWzRY32qA35uwGsPqFLgARQtuZrauYBga+68
         Pj9HC1l0JKcABooNy+hhg2AXuQzG+p4UAO9p/jVCMuN1Jg2MDVaYhMc6wnYeKxAjdwZz
         HKpbzwjP4nFzoPDo8Nu1WEsosGzUTDkgwRVGeVCoW22RId9iJZnS2mkPBlWYFpgs5z/e
         thQVgkVriJgEM5XCmY5py7msE/4YsA8Y2Lf7TOhEf8euVfLK/qtsR//EbPY16yof6XgG
         r/kuOe0DayoE3EC2HNaLKLcDaVu1xCQhc64+svGTpN1RMhrYe+RBYnybEuwIqtNs8DcC
         ySRQ==
X-Gm-Message-State: APjAAAVzhrI66Y39VTGCWxrHzuyWU+euUUCZE0ymzTYsVav2ER0c7sjD
        3Fcy5cqKVxaTGnMskgOjDd4=
X-Google-Smtp-Source: APXvYqybifQ3qr7Prfv7nDSUNkZPs8VOjsT27l44HHCNauSukaXZgizew9X8FsbVU/z81ut2lYsuWw==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr6772673plq.154.1570060786431;
        Wed, 02 Oct 2019 16:59:46 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i7sm350238pjs.1.2019.10.02.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 16:59:45 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:59:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lis3lv02d: switch to using input device polling mode
Message-ID: <20191002235943.GC20549@dtor-ws>
References: <20191002215658.GA134561@dtor-ws>
 <201910030738.k8Pojn6c%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910030738.k8Pojn6c%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 07:30:23AM +0800, kbuild test robot wrote:
> Hi Dmitry,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on char-misc/char-misc-testing]
> [cannot apply to v5.4-rc1 next-20191002]

This is weird, I just tried applying it to both next-20191002 and Greg's
char-misc/char-misc-testing and it applied cleanly and compiled (on x86).

> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Dmitry-Torokhov/lis3lv02d-switch-to-using-input-device-polling-mode/20191003-062746
> config: parisc-allyesconfig (attached as .config)
> compiler: hppa-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=parisc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/misc/lis3lv02d/lis3lv02d.c: In function 'lis3lv02d_joystick_enable':
>    drivers/misc/lis3lv02d/lis3lv02d.c:713:8: error: implicit declaration of function 'input_setup_polling'; did you mean 'input_set_capability'? [-Werror=implicit-function-declaration]
>      err = input_setup_polling(input_dev, lis3lv02d_joystick_poll);
>            ^~~~~~~~~~~~~~~~~~~
>            input_set_capability
> >> drivers/misc/lis3lv02d/lis3lv02d.c:717:2: error: implicit declaration of function 'input_set_poll_interval'; did you mean '__put_user_internal'? [-Werror=implicit-function-declaration]
>      input_set_poll_interval(input_dev, MDPS_POLL_INTERVAL);
>      ^~~~~~~~~~~~~~~~~~~~~~~
>      __put_user_internal
>    drivers/misc/lis3lv02d/lis3lv02d.c:718:2: error: implicit declaration of function 'input_set_min_poll_interval' [-Werror=implicit-function-declaration]
>      input_set_min_poll_interval(input_dev, MDPS_POLL_MIN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/misc/lis3lv02d/lis3lv02d.c:719:2: error: implicit declaration of function 'input_set_max_poll_interval'; did you mean 'input_set_capability'? [-Werror=implicit-function-declaration]
>      input_set_max_poll_interval(input_dev, MDPS_POLL_MAX);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>      input_set_capability
>    cc1: some warnings being treated as errors
> 
> vim +717 drivers/misc/lis3lv02d/lis3lv02d.c
> 
>    671	
>    672	int lis3lv02d_joystick_enable(struct lis3lv02d *lis3)
>    673	{
>    674		struct input_dev *input_dev;
>    675		int err;
>    676		int max_val, fuzz, flat;
>    677		int btns[] = {BTN_X, BTN_Y, BTN_Z};
>    678	
>    679		if (lis3->idev)
>    680			return -EINVAL;
>    681	
>    682		input_dev = input_allocate_device();
>    683		if (!input_dev)
>    684			return -ENOMEM;
>    685	
>    686		input_dev->name       = "ST LIS3LV02DL Accelerometer";
>    687		input_dev->phys       = DRIVER_NAME "/input0";
>    688		input_dev->id.bustype = BUS_HOST;
>    689		input_dev->id.vendor  = 0;
>    690		input_dev->dev.parent = &lis3->pdev->dev;
>    691	
>    692		input_dev->open = lis3lv02d_joystick_open;
>    693		input_dev->close = lis3lv02d_joystick_close;
>    694	
>    695		max_val = (lis3->mdps_max_val * lis3->scale) / LIS3_ACCURACY;
>    696		if (lis3->whoami == WAI_12B) {
>    697			fuzz = LIS3_DEFAULT_FUZZ_12B;
>    698			flat = LIS3_DEFAULT_FLAT_12B;
>    699		} else {
>    700			fuzz = LIS3_DEFAULT_FUZZ_8B;
>    701			flat = LIS3_DEFAULT_FLAT_8B;
>    702		}
>    703		fuzz = (fuzz * lis3->scale) / LIS3_ACCURACY;
>    704		flat = (flat * lis3->scale) / LIS3_ACCURACY;
>    705	
>    706		input_set_abs_params(input_dev, ABS_X, -max_val, max_val, fuzz, flat);
>    707		input_set_abs_params(input_dev, ABS_Y, -max_val, max_val, fuzz, flat);
>    708		input_set_abs_params(input_dev, ABS_Z, -max_val, max_val, fuzz, flat);
>    709	
>    710		input_set_drvdata(input_dev, lis3);
>    711		lis3->idev = input_dev;
>    712	
>  > 713		err = input_setup_polling(input_dev, lis3lv02d_joystick_poll);
>    714		if (err)
>    715			goto err_free_input;
>    716	
>  > 717		input_set_poll_interval(input_dev, MDPS_POLL_INTERVAL);
>    718		input_set_min_poll_interval(input_dev, MDPS_POLL_MIN);
>    719		input_set_max_poll_interval(input_dev, MDPS_POLL_MAX);
>    720	
>    721		lis3->mapped_btns[0] = lis3lv02d_get_axis(abs(lis3->ac.x), btns);
>    722		lis3->mapped_btns[1] = lis3lv02d_get_axis(abs(lis3->ac.y), btns);
>    723		lis3->mapped_btns[2] = lis3lv02d_get_axis(abs(lis3->ac.z), btns);
>    724	
>    725		err = input_register_device(lis3->idev);
>    726		if (err)
>    727			goto err_free_input;
>    728	
>    729		return 0;
>    730	
>    731	err_free_input:
>    732		input_free_device(input_dev);
>    733		lis3->idev = NULL;
>    734		return err;
>    735	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Thanks.

-- 
Dmitry

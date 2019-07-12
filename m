Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E26BC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78642054F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvbNRCUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfGLR5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:57:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38121 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfGLR5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:57:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so10823695wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=12w9YhMzTEceI3FF8gxwRGTZ2SJpBQ7cKMo01O/ztWg=;
        b=fvbNRCUcHA5EF9w5+GiQrvMVZgK4Z0RBqPLbianwHZkzj1Wfcf6+EnVXvGLL20HLbN
         Rpt6Q2WvRtCkuXEIE13mkicHw/oNEAOvLy7KjqmEkK+FFN3Nq+RTOsBt137F5L1zJxfv
         XlRM37RIAZunhOcn6VmGJGkDf0B0ktuTTepU7L3c4hhikgOdkwWzNPwqgAPZ9ty9xRcM
         FaFD43oWmyDMbqsN8AkxuVT19TsIFc8svNEaKjSZM0VDeEjNtosfuNQZ8lL1HApsc+yi
         XiivUaq5+1DRpO+VeF24tCLdUYr9JpiXv1Wrc0w1ATm/xYbrp3NICswOxja7f931ClFI
         fDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=12w9YhMzTEceI3FF8gxwRGTZ2SJpBQ7cKMo01O/ztWg=;
        b=cdQsv0SeD8JyknaGxFV4aLgeqf6KibG0R6RZ3jkUBKr7pSIgVziuzFu9BL4LoJhV/P
         hm3KuOQqplLdEHo+jL5Fxt4BJYbZrO63xBQ+XmJQr5N30oN7yu1sRkkeFOrCrw/xoetj
         IpddDoFPpjM38yemeHRlNfO8faTBJJUNrHfR+PcfxvKmuov6soGpZTCH79VN8XFLXSOF
         utBcEKBequAefNKOZgB469/FTB3StjwOVB1PyLqh5VNCjP6LVMxcjbZrdSdaqQiiTMCB
         b90glIL3PCC1bOybX1PMb+k5Ppkj99uFCJnVC5DQ/1NmeEEplrsWhc4wMUvXrxa0UMMi
         lbWg==
X-Gm-Message-State: APjAAAXoy3poGTl1RivlekjnLFJQdZo56esi6kB65dBk1cI+tBwANbDz
        WZKF3Zoz2rszNU7l82J0sr0=
X-Google-Smtp-Source: APXvYqwuYdWB6sJTcg7lu3ary3cXGkPst6uJsKQ/xPttRCCOP42sFPSCTNUAC/5rbJqH417Atb6nRQ==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr12758036wrs.105.1562954237869;
        Fri, 12 Jul 2019 10:57:17 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c14sm7204278wrr.56.2019.07.12.10.57.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:57:17 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:57:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Charlene Liu <charlene.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/amd/display: return 'NULL' instead of 'false' from
 dcn20_acquire_idle_pipe_for_layer
Message-ID: <20190712175715.GA21080@archlinux-threadripper>
References: <20190712094009.1535662-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712094009.1535662-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:39:52AM +0200, Arnd Bergmann wrote:
> clang complains that 'false' is a not a pointer:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:2428:10: error: expression which evaluates to zero treated as a null pointer constant of type 'struct pipe_ctx *' [-Werror,-Wnon-literal-null-conversion]
>                 return false;
> 
> Changing it to 'NULL' looks like the right thing that will shut up
> the warning and make it easier to read, while not changing behavior.
> 
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

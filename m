Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEE2C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AEE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5PM/hPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391330AbfGRVbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:31:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36922 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:31:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so13193534pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=knozEXRhXWvdO7buD7BicWZWalyyFDnCOXnDxt6wCPU=;
        b=m5PM/hPG+b9HQoKIZGbV+Ijuf2K7lQCUeVE/31Yx0s2UJXJinuR6TELqMMBQe1zNK+
         ITaF4LxTfpVYJT/CB5uauiVzBIPXdmJOiNiHEeLPUYTc8daNjxKKpM+5C/igF5zhrMkY
         /dg5e5/uO7JhNJ/T3J42WAIKkjI6M+DcpIRy3c80cp+0VFInZXxdthcYl6i8hH6m4JNj
         j2V3FyAxSuy5KM7hfAhUZaFUSwuaKxs+KQ+oKowAuYtAOHsfsxVKNnqPIlHfxaTGTwux
         Mi40vng0pTS6OLBl6pMVGG/F1rxxCimHBrEo28sK8by3GCDNubTjdjUIh51eN4R4vbhw
         KMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=knozEXRhXWvdO7buD7BicWZWalyyFDnCOXnDxt6wCPU=;
        b=GYc3O+SWPBX7TWuHygnEjUoit0QeI1kfdy5uuznJKkiO7m7MWpebq1RHF+EtagJRj1
         tmVW3ccixTBe9Y2ugk+gOu51pjR2XFLfctU3XKAjRF31Hc4ERwMqbd0ZZPakos5XQDJm
         Lzwn0fe6wtJLAXmISsYd1hFSdjuDxZf4DdFQOcQ6ZXK+hMldDyqL8RNzHj0V4pUhXeT4
         2IP+dWICIFc/+UYs/5fQ59wuGWfqtcZ74cs2A5diPGbl5KyAgZ4ajSSGCrBw0eTgfiDV
         boAITnOJpHk4UXP/TJf9udjO1heRkB7XsEveZZ3tJQ/uWkdua/TqdDBeaPwUKu4EF89s
         giJw==
X-Gm-Message-State: APjAAAUHUrVE1jeT+FL08uoocm/f+eEcBjP6wCO+0NkUo1r8AZq1zLc9
        cMx9KFUOWhjLb7lcYBs79XRljA==
X-Google-Smtp-Source: APXvYqwt4Z+EcKNr4IglRcV9oiMsLHIXxnnhpixhnoN9PRcEQhoL633rKS/P9Lo0QuqjfEkYVbLOgw==
X-Received: by 2002:a63:1305:: with SMTP id i5mr50423942pgl.211.1563485497578;
        Thu, 18 Jul 2019 14:31:37 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id v3sm26810539pfm.188.2019.07.18.14.31.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 14:31:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] f2fs: Support case-insensitive file name lookups
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
References: <20190717031408.114104-1-drosen@google.com>
 <20190717031408.114104-3-drosen@google.com>
 <cbaf59d4-0bd3-6980-4750-fbab14941bdb@huawei.com>
From:   Daniel Rosenberg <drosen@google.com>
Message-ID: <4ef17922-d1e9-1b83-9e89-d332ea6fb7ae@google.com>
Date:   Thu, 18 Jul 2019 14:31:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cbaf59d4-0bd3-6980-4750-fbab14941bdb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/19 3:11 AM, Chao Yu wrote:
> We need to add one more entry f2fs_fsflags_map[] to map F2FS_CASEFOLD_FL to
> FS_CASEFOLD_FL correctly and adapt F2FS_GETTABLE_FS_FL/F2FS_SETTABLE_FS_FL as well.

I don't see FS_CASEFOLD_FL. It would make sense for it to exist, but unless it's in some recent patch I don't think that's currently in the kernel. Or are you suggesting adding it in this patch?


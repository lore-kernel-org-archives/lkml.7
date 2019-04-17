Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B248C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A505217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hkon1cQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfDQO4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:56:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45435 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbfDQO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:56:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so14621818lfl.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mk/h0ksVQEAwQqHjhUV2k1eX+bIopg49QdT8kRGZWO8=;
        b=Hkon1cQYv14rOR9EdPlE70ds2i5i5CkCbWk7ULLBiRA43mzh1k/YY3AXX+XGixImf1
         vRNdf87oAciKM2hZUsuWjUibLcpPuvHwv5v9e3/ARSjVgibJfu+RODfq6HrCsjJymE+2
         ylly+Cv/XizGynSILek0JoiDryAR45M/T/J4gNPWdTJwnPE6hdCnyE9OnzcU+wkqtz4D
         FPwlG/sdY6xZYkSQykIXU9THXHNoFhVUbQItTpwgtbFAV90EyJy2Fslw3ji1JN4QWmpx
         DO74qHSHnk55+3B3dB/oERzV3huArMFGZsejwTY1SaUPtdY5ndkxsC6ksl2oeW8m7T16
         7cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mk/h0ksVQEAwQqHjhUV2k1eX+bIopg49QdT8kRGZWO8=;
        b=luBtiuSwfc+iGekdUw/yIdq5Z3FFWBgZUgb60wFWyRllnq0EodSRB/K4RmVZxkJejg
         IaOX9ajaxG7P6cakDmMpgHEAMVTWIW/5YL8iBmU1VUZ6YA7GDz76edTPRwlAiNBkdEPv
         l2A9heom5D9ftaw4avSH+I2RFSTafWIIEsaPKSz5hp+rGLXo84oMKYNB3qs+7nEcxbSy
         7Q9UHeSx7bZtD16ChymCN4GDXTNzPyBnEwUa8gG01FHoCALiRvW9KeZTeErGRmLIDJOM
         xybLIDWcsaBIya2O2ESuadNZyI25MDlp3iHcPqKW6D05xnMetJ5TZDg6mtRldj331pHO
         02Bw==
X-Gm-Message-State: APjAAAWLKmSTXVIGaCInQ/AfDoz6c1OxmhKDybQlLf3gygAjmdtRUAcq
        P71mpKDDUI5+0MlXhF8re5k=
X-Google-Smtp-Source: APXvYqx4mH0hEpO07GuBNv73YKfYrNnQM+/DqYBRWbK1zvD18LlpV/QyO7tJXNaJUAIRfufcp479Bw==
X-Received: by 2002:a19:3f54:: with SMTP id m81mr18970142lfa.98.1555512969220;
        Wed, 17 Apr 2019 07:56:09 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id e17sm10847312ljj.20.2019.04.17.07.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 07:56:08 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id EBA8F46010A; Wed, 17 Apr 2019 17:56:07 +0300 (MSK)
Date:   Wed, 17 Apr 2019 17:56:07 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     kbuild-all@01.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Andrey Vagin <avagin@openvz.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH] prctl: Don't compile some of prctl functions when CRUI
Message-ID: <20190417145607.GB3040@uranus.lan>
References: <20180420140044.478b4c88d3cf238bd440f2a7@linux-foundation.org>
 <20190417122349.GA15498@blackbody.suse.cz>
 <20190417123841.GA3040@uranus.lan>
 <20190417144454.GG8962@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417144454.GG8962@blackbody.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:44:54PM +0200, Michal Koutný wrote:
> On Wed, Apr 17, 2019 at 03:38:41PM +0300, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > I've a bit vague memory what we've ended up with, but iirc there was
> > a problem with brk() syscall or similar. Then I think we left everything
> > as is.
>
> Was this related to the removal of non PR_SET_MM_MAP operations too?
> Do you have any pointers to the topic?

Gimme some time, will reply later.

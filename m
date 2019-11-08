Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DDFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22F21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vorgUDj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKHPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:35:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44072 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfKHPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:35:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so4780876pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbqjUWGDXWIaVy6iV3sdofZ0jxt/pVLpoh92ATrPX1Y=;
        b=vorgUDj6+6UmJsxUwlznw94CFZybpHAl2ne3wb2WfWG1z8CgLHiINfPY04JeSC+0k1
         /1ztuPLxGB1SErJB1Qvk844TfucGzjQjyH+5c+Ilc4DHUnYlFCfSYrjWcXtv6P6NNdKd
         I3tYRrSpNfjKot7F5PnRxv/1pPMmbNhi533jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbqjUWGDXWIaVy6iV3sdofZ0jxt/pVLpoh92ATrPX1Y=;
        b=q3eXH6AZNQ3Ls1ACysW81ScFGz+t8PhXmAI0OG2Sh+fCObbFrIRB7EMkis3Ex5j/eE
         xQ+CW5gtlcJXCbI/bjvdYXn4HGjOxq3PXU0Tgix3Y6IIp12EyAbeYSQLgGV8ugzUGx7b
         ndpwuHv9l6L7vOUXVJstx3PhVV+rX+02AlA/jLyRYQP8WftgZTBNdNkbsWIsVn6tlMwD
         ZYHIfoWfLmGHDiKjiXsHh1bvR8SEn+YbCuzU8Fm5FsdQ1/WleqYaAJb/h6Yge8WMns2e
         gcIgn1ShCTeqsfccs9Iy++6jyMXTq23NY50fJLIBssZdZFxWQXUQNqpuwQpQtXl6og7E
         nQ1Q==
X-Gm-Message-State: APjAAAVGPnEtUPoUIlwe/e/c76w5KDRJgKYFeXkk5SalIlD9NuwZmfLO
        5B39xTDbwh9I6mh8CxOJQWnYWQ==
X-Google-Smtp-Source: APXvYqwb/aQ3D7gYofOFDmeLVdI6s94UZkNaBx0GgMxCmDj+wJ0R0I6NwdU1Nlz6L3VGQ3sxGI1pxw==
X-Received: by 2002:a62:d44b:: with SMTP id u11mr12485806pfl.259.1573227345330;
        Fri, 08 Nov 2019 07:35:45 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j7sm5528054pgl.38.2019.11.08.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:35:44 -0800 (PST)
Date:   Fri, 8 Nov 2019 10:35:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108153543.GC99567@google.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
 <20191108063308.GB18778@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108063308.GB18778@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:33:08PM -0800, Christoph Hellwig wrote:
> > -		 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
> > -		 * read-only mapping, take care to not allow mprotect to revert
> > -		 * protections.
> > +		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
> > +		 * MAP_SHARED and read-only, take care to not allow mprotect to
> > +		 * revert protections on such mappings. Do this only for shared
> > +		 * mappings. For private mappings, don't need to mask VM_MAYWRITE
> 
> This adds an > 80 char line.

Oh, true. Sorry. Andrew I hate to ask you but since you took the patch
already, could you just the comment for the character limit in the one
you applied?

thanks,

 - Joel


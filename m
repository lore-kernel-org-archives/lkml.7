Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA20C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7662084F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHW0mNQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDJBrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:47:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46287 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDJBrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:47:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so475321pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 18:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+cKbWneDaL7J/POBAq3ubf4NsXKHLrEQmV/5wOkRBY=;
        b=MHW0mNQgaHmwWnLa40ahK5abHTZ02jNDmeOr8NOgAH7jh64wPT3rMp6vvABhnd4QwK
         MlhL47TvM5PHQdnKx02fMvLmIiO75X5x1b6jFj4DeQZtc3TIu+eGR8r172TLzoCeN8ec
         rkYxTiYEUvH5mqDsv8Pr6mJTJgWMnAuiB5lcY39nzCRcCib5v51Hha0LBicJE3HMI+bY
         7VZ8qjwGYnMgX/Phyy7lDDeieL5swGzYvx67Y0rFyjt4vMmC7lUZg5xFsQ5Hg6ku4r6p
         O/K727CDYawT5WY4lA2F/xx1HoGWwer6XsFxKlu22oL2syoGpsHpNHpKLx6XZugqL0jT
         2ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+cKbWneDaL7J/POBAq3ubf4NsXKHLrEQmV/5wOkRBY=;
        b=bn1am/1clonwTg2dCyAalfZuQ0RTLxbS5mwEOf8kSTfmrDp9I4gOqYYcugZUVfuJGy
         F5xkVGgqUzhAV+e6iby8HcwUbJNcx9i03tjhvJq25pkSWJ1JwnTZx7r75YOckX01g1Qk
         rRlWWg3Xt78SrmDuWyfQgEDNG6zOWIxxO8jaP+I29b6ztgLmg4we2yR2u4I6WVGGxbcS
         A28WTIu/RqM6hF0plrabwb8Xh3zzcbIHEO1qYOhpW0loYwN+fGJrdToAqqFg4q7m8dUM
         WthSB0DbaXBHstZmaoi9bczXjE+gHzZl5e+P03IlkzcLVW3eLV6lQe4iTmGrSPXGwfqS
         2UOw==
X-Gm-Message-State: APjAAAX0GCUKJEiN4rYrFbYskHjyXIVYmcGYPi0Bs5IiBmXQhhHfXCZB
        xh5zzvrRRXvGHSG42fb39yE=
X-Google-Smtp-Source: APXvYqwd4/i5mIKUX9QhNXh5PRapfMAI/SjDmwXYOdCiUFAOChkYhodiD/P0hUiALUrpMdtTnKCekQ==
X-Received: by 2002:aa7:920b:: with SMTP id 11mr40402154pfo.3.1554860829332;
        Tue, 09 Apr 2019 18:47:09 -0700 (PDT)
Received: from localhost ([175.223.11.210])
        by smtp.gmail.com with ESMTPSA id q77sm26088869pfi.45.2019.04.09.18.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 18:47:08 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:47:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 1/2] printk: Add an option to flush all messages on panic
Message-ID: <20190410014705.GB26212@jagdpanzerIV>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <20190402021419.GA617@jagdpanzerIV>
 <20190402022840.et7sbiamxeutbw2q@shbuild888>
 <20190402022900.GA2219@jagdpanzerIV>
 <20190409134109.ounidzwphouqr3w2@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409134109.ounidzwphouqr3w2@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/09/19 15:41), Petr Mladek wrote:
> I suggest to merge the two patches into one. It will
> still be rather small and easier to review.

Agreed, was going to suggest the same.

	-ss

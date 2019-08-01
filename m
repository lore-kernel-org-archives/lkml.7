Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB71C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD19206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="b5JIUkRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbfHAWH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:07:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42120 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfHAWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:07:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so75995680otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d66Dx5tht3bIubrAALEmO9FsXpeA3XHRtZ+CvWmAzQ=;
        b=b5JIUkRUV0g59d/ktuCiATKF7wwGGFI9elm07cwD5p+GrVFeSMqW8t1QuZqlT1lT7y
         ed+UfqDJmE+n4XHon639NUlemgv3jgQaFEYF6LXE4UmBeT47f+sfUqH+5kPb1NreUves
         5wSgSHWJzrDu8+wbKPmaiR5XdtPtBBf3cnZmuUE3zk1JMeio47Ca+38vgBViUeoS58HS
         CL2rDz4g695xAEIoJ2RRgpV7rvL9+gSWWkmtTUf6jUEQgJyZ9aFFBmLUCrA63SnEi+2b
         mAoeICiQI6icOfuZ+SuvMCXYiVe9cWDj4PYp04G5vewtmMD41nT3cOgQRdX/9MQP6FE1
         5FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d66Dx5tht3bIubrAALEmO9FsXpeA3XHRtZ+CvWmAzQ=;
        b=TrqwePCK/wiJNRgUofgULBsD+gPoAX9lkbnnOzj2L6uCmb9MWYnCdfSNeeFweNuTLd
         1cCmdsJCroAaaP7aFMOCQ+Xrn6qt6N6gDjoCRtTzaIRV3oXsjz7SmEvoODjh8AzBVaUb
         +Hpy+aubinue7FKW0XkqCrbrou2bRDqzVwICJyo3B/CmgyXUkDRuNcFIzc5E2kPn9eZ4
         QucDe8TxHwGINvs+GQnlbx6DTZYQ6+Wq7Vk3sTDsi/PiyczWBCxMcahxLG3fDxkOg5ne
         t2xKn0MwBNSSljsYVqaNvh19y4LdetlYjd1zoPpE0SaksJ+ZKJVtCRlOVTjkm7hbn1uP
         s1rQ==
X-Gm-Message-State: APjAAAWrJSa4UHCBxihNN5Hl6V5vR0ZbxUKnXyzy+9qNDq1rf7DQyRjJ
        NeAwOh2fn8eLgQp4yuZclI+1zPeWeJV2o1sYS+E=
X-Google-Smtp-Source: APXvYqztC6d2JL7T5A6ZXy62TT29JOHO4N1GO1DWFj/SVQmPqGS95r35F5QH7LXc9/LPGu7z2wVsfuB0ezqnAqTHt7k=
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr67528087otq.197.1564697276304;
 Thu, 01 Aug 2019 15:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190730212048.164657-1-swboyd@chromium.org> <20190730212048.164657-2-swboyd@chromium.org>
In-Reply-To: <20190730212048.164657-2-swboyd@chromium.org>
From:   Tri Vo <trong@android.com>
Date:   Thu, 1 Aug 2019 15:07:45 -0700
Message-ID: <CANA+-vDCauCh-Ds3xVawYAhWyLpFHqn92fdYL316M5GfxTGvZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] idr: Document that ida_simple_{get,remove}() are deprecated
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 2:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> These two functions are deprecated. Users should call ida_alloc() or
> ida_free() respectively instead. Add documentation to this effect until
> the macro can be removed.
>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Tri Vo <trong@android.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tri Vo <trong@android.com>

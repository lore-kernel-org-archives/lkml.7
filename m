Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB726214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrqMRtFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfIPRNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:13:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41008 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfIPRNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:13:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so171921plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWIZJlqhAHtTIx9X5zi5DWCFg3CgWDLfKyYu8B/Dqv0=;
        b=UrqMRtFBE3GvXdEZ3mz4KBdCWATWrVzB6xgssl49LAHwSohPzBdZJbplA59O71t985
         cWOud704jWTuXFIfoEzNU8GTIoCTe66JMMUmaDUEEyBlFVzVcCjkYofMbv29jQb4PFsy
         FrVBD2XlSEive97gMw66440RS2zDoTjKu9cZ/fSvfWmIGk/lhl4GU/N/I3k8VNfFZDHh
         qMJSe136OsJ9MwVRTU5sgRgLdHDSZN89BsuJ+Dyx9uYmjVFJbTLQ4thjOhXbPOpYbB4k
         PG2/9K2yG4CYVAjChzHpkVeArQkDkvxothAZHqdljNQK+TZm0JT7JMHMzx9KMf0VGN0w
         V8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWIZJlqhAHtTIx9X5zi5DWCFg3CgWDLfKyYu8B/Dqv0=;
        b=n/ZFaE9XiIHag0Bqp0QsHR0RF9lWzptArT/8W/ZdR1lYC5gTd3dsgigj+60xK7QvBT
         j7CUKrNnAJ1CqNwUcO9KgXduGQ0BagD4U2S1fjqnrj/N8x0M2JTLLvzLH8cBzBuLorqp
         6kYomn22hMW51LG5aYD4ICNEjAZZHGt2WzumWcpZorsR9TMd6OP9n0GxSst3ac4/LWSM
         vOLmU5fB/Zf6C9MBCpUN6roBBC1s0U9opkJ4sJ3h4RxVDKZ+l5dIcnhhT2+c4HtVI88H
         I5/bejqP/EOtUxEls+vlMxfVsG74nlLX1B64cFpZ1LgNVHLL+6msHl2JaO9osC9HnJgN
         56Ow==
X-Gm-Message-State: APjAAAX1zjhdeU15e4aOVJSNPMcf1Orl63tIWaiOZemWpFblTVB6nq8r
        dJ7a1s6ndDd7QkW2nOpr5mw=
X-Google-Smtp-Source: APXvYqwmpHdgGrbxJrWzk50f44QiS45DqOLgPoVS0nGtu/YyRgndV12FUcJZMiB2gxqgk/xkCGdlSQ==
X-Received: by 2002:a17:902:248:: with SMTP id 66mr867870plc.19.1568654021414;
        Mon, 16 Sep 2019 10:13:41 -0700 (PDT)
Received: from SD ([2405:204:828a:aaec:8514:49dd:92d4:793d])
        by smtp.gmail.com with ESMTPSA id q71sm124375pjb.26.2019.09.16.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 10:13:40 -0700 (PDT)
Date:   Mon, 16 Sep 2019 22:43:35 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: omfs: make use of kmemdup
Message-ID: <20190916171335.GB4060@SD>
References: <20190913171134.GA10301@SD>
 <4fd20946-b991-0c0f-975e-ef79b433912b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd20946-b991-0c0f-975e-ef79b433912b@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 08:24:37AM +0200, Markus Elfring wrote:
> I suggest to take another look at a similar patch.
> 
> fs/omfs: make use of kmemdup
> https://lore.kernel.org/r/20190721112326.GA5927@hari-Inspiron-1545/
> https://lore.kernel.org/patchwork/patch/1102482/
> https://lkml.org/lkml/2019/7/21/40

Oh I missed that. The patch you pointed above is of July, 2019 but I am
not seeing it in v5.3 or in next-20190915.

If you know, can you point to the fs/omfs tree. It will help not to send
repeated change.

-Saiyam

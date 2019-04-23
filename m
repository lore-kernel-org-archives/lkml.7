Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2519D20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqkj5CLe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDWItm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:49:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38147 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:49:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so7129032pfo.5;
        Tue, 23 Apr 2019 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G7gJmN0ZEAmx+/+040CXf4sNaMmpkACYks1kixlKJ10=;
        b=Sqkj5CLeaeLY4PbXVpJBRwhVbeQO/PKxXMQN2zym3xwApoL52y0WiCHJExOLN2PjiF
         rdwJj3nfc5cldWqbVYLyLwu4dBfEWYAxEUkaGCB/qHFOl03QUXXfKkxrou/qoA5CnRpT
         blNYexhCOErJCvuW4h/HdDmfaZ0GdyCB6RHLIVj70+DfWMAyGOve29iH3EM2tYzrHMGD
         4UOSrac/gQTHe//b630waOmIFfBSWQI6tF0Zwrkb7hsZpMz/hlH4G2kp8KU4jwPzSdyL
         OTx5c6YYLsVdFnPmabL2ypbF126flzizM3ik9A4JuF3u5WLcBZrTHnqY1xwTzBTNURT7
         O9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G7gJmN0ZEAmx+/+040CXf4sNaMmpkACYks1kixlKJ10=;
        b=n+9IdstO4dM/7ttNjosiHMwbScd4cD53r/8YKImH9zd7WQujNqXIAFTNIrWKTBuNg/
         Ig5VB02r7clWXmY/JrlsvdGkqjZIcAkzArRxHMlt8n1dhKVO38bZm+/q5m4gvxOokj/P
         qieGTTAWjq1YFXNmWsYZLnob1+aqyirAL8lRDcK9U5W2H+PZPxL3PVDIUjfv64OMEJnj
         520HBLqUBO2cYPOj+Du+n19vCUVJTJGkrc9NJCbRChJrXEJ8GIJLFQSnadFTj3fn+fNk
         7+VITCybCErP4qpD1mzFENq8zA1i4Gcr2lCo8Ny8I0o2kpP7CWtCxRDCGguQA0ydxgdX
         IhMw==
X-Gm-Message-State: APjAAAUtINchXqKrINCpOlcz7dVeNP/TkCPvU4H/iVUlD3jVVTwOrD8V
        A8afW9vPEEUmGpW7DeMtPHk=
X-Google-Smtp-Source: APXvYqwOOdTDI9c4cT7+1hmiQfxzzOUpv/nN+/mq8MD5d+hdwPiJf8uqkXJ3lUBWU5HRJpjZou6dAA==
X-Received: by 2002:a63:c54d:: with SMTP id g13mr20457512pgd.376.1556009381209;
        Tue, 23 Apr 2019 01:49:41 -0700 (PDT)
Received: from localhost (p1962055-ipbf905funabasi.chiba.ocn.ne.jp. [118.15.107.55])
        by smtp.gmail.com with ESMTPSA id f15sm18762775pgf.18.2019.04.23.01.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 01:49:40 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:49:44 +0000
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Mukesh Ojha <mojha@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gaurav Kohli <gkohli@codeaurora.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Martin Kepplinger <martink@posteo.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Message-ID: <20190423084944.gj2boxfcg7lp4zad@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:51:13PM +0530, Mukesh Ojha wrote:
> On 4/23/2019 8:58 AM, dmitry.torokhov@gmail.com wrote:
> > On Fri, Apr 19, 2019 at 02:13:48PM +0530, Mukesh Ojha wrote:
> > > On 4/19/2019 12:41 PM, dmitry.torokhov@gmail.com wrote:
> > > > On Fri, Apr 19, 2019 at 12:17:44PM +0530, Mukesh Ojha wrote:
> > > > > On 4/18/2019 11:55 AM, Mukesh Ojha wrote:
> > > > > > On 4/18/2019 7:13 AM, dmitry.torokhov@gmail.com wrote:
> > > > > > > > On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > > > > > > > > uinput_destroy_device() gets called from two places. In one place,
> > > > > > > > > uinput_ioctl_handler() where it is protected under a lock
> > > > > > > > > udev->mutex but there is no protection on udev device from freeing
> > > > > > > > > inside uinput_release().
> > > > > > > uinput_release() should be called when last file handle to the uinput
> > > > > > > instance is being dropped, so there should be no other users and thus we
> > > > > > > can't be racing with anyone.
> > > > > > Lets say an example where i am creating input device quite frequently
> > > > > > 
> > > > > > [   97.836603] input: syz0 as /devices/virtual/input/input262
> > > > > > [   97.845589] input: syz0 as /devices/virtual/input/input261
> > > > > > [   97.849415] input: syz0 as /devices/virtual/input/input263
> > > > > > [   97.856479] input: syz0 as /devices/virtual/input/input264
> > > > > > [   97.936128] input: syz0 as /devices/virtual/input/input265
> > > > > > 
> > > > > > e.g input265
> > > > > > 
> > > > > > while input265 gets created [1] and handlers are getting registered on
> > > > > > that device*fput* gets called on
> > > > > > that device as user space got to know that input265 is created and its
> > > > > > reference is still 1(rare but possible).
> > > > Are you saying that there are 2 threads sharing the same file
> > > > descriptor, one issuing the registration ioctl while the other closing
> > > > the same fd?
> > > Dmitry,
> > > 
> > > I don't have a the exact look inside the app here, but this looks like the
> > > same as it is able to do
> > > fput on the uinput device.
> > > 
> > > FYI
> > > Syskaller app is running in userspace (which is for syscall fuzzing) on
> > > kernel which is enabled
> > > with various config fault injection, FAULT_INJECTION,FAIL_SLAB,
> > > FAIL_PAGEALLOC, KASAN etc.
> > Mukesh,
> > 
> > We need to understand exactly the failure mode. I do not think that
> > introducing another mutex into uinput actually fixes the issue, as we do
> > not order mutex acquisition, so I think it is still possible for the
> > release function to acquire the mutex and run first, and then ioctl
> > would run with freed object.
> 
> I have taken care this case from ioctl and release point of view.
> 
> Even if the release gets called first it will make the
> file->private_data=NULL.
> and further call to ioctl will not be a problem as the check is already
> there.

Al, do we have any protections in VFS layer from userspace hanging onto
a file descriptor and calling ioctl() on it even as another thread
calls close() on the same fd?

Should the issue be solved by individual drivers, or more careful
accounting for currently running operations is needed at VFS layer?

Thanks.

-- 
Dmitry

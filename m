Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A65C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0662214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xzb1Bg7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEHCSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:18:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34099 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEHCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:18:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id m20so820367wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 19:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2VQYmcOhfKzkM0UugtZ6mKBvbFSRbfp3capv5V8nMNw=;
        b=Xzb1Bg7BQV7IlwuVho+Y2FAzS7+4V/AblssRM+CZs1Q6GtbB2f3dDtLYt6344mfRrr
         1lY7KOT8XsEDplUFVBKcgJ/GOBz1C6oWAN33mepUNA4gBj1gEcjBqelBA4coWfwv55RQ
         CTxT1ixJianc5C/PwzTAxgf3ykxLPTzmpS6ihRcJ0Kenf+B3tU3qV3RzuBQ4BisncGRK
         yexLD40nG3Db8ePlVgikd1XuYCVmvRVu8PY/eRFyY8u5cWowYuOhLf5ZHn4mk151yXho
         D7YyiadnfxqSb1UMIxkeH7MQ906jiqrjuMj2noJ/NjBIDq+P/LBOXMqY6ik3cwAWpdAs
         dH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2VQYmcOhfKzkM0UugtZ6mKBvbFSRbfp3capv5V8nMNw=;
        b=kK7lsWBmAnqIx0e/sZmzET1902URaBXO0UKHxwKJkcWEwAVLVLONSnvjM3SHG9IOUb
         AmqyNL/54hYtVdf18mO5xfnoL7OOZqU7jILofZszhaZURualVeOR6g+FYkd6E2sCZ3eW
         6wuvDE7a/wCfFOVCdohppJ20NJktVXnhvr2RcyWys7+CnIB+YrcYccn+/KGr6Ar69BCO
         PsJx4hTws6o4tyrT2uCAuQ+4ouXiji4ShTB72j9Kvzr9LchtD9CSCfombJFlUQUBtPYD
         mwErY76GNhGLIRx5VkfG2ihQtkaYKou6xW+qPOBVZgdq8R2/IwEM6JnAmx7oQD/2wbJ7
         jxKQ==
X-Gm-Message-State: APjAAAW3X+RO2RvT0AS0dC+CuHJT/3e3Dtx+AY6lLoal7mBqFJymnIUI
        HHF06QDx656/kwze4gFNKp98eVyNv2FruXSVxuoIqw==
X-Google-Smtp-Source: APXvYqxb9e/yUxVyvriVVzvxf06ff1qHb493UqijikoLDgmvw8T5PcvPPnrbBZbzN/ZbQb3/QTqSJLORpY29COaBfGo=
X-Received: by 2002:a1c:a751:: with SMTP id q78mr929450wme.64.1557281928986;
 Tue, 07 May 2019 19:18:48 -0700 (PDT)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 7 May 2019 19:18:36 -0700
Message-ID: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
Subject: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     Felipe Balbi <balbi@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Cc:     "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather
buffers"), I've been seeing trouble with adb transfers in Android on
HiKey960, HiKey and now Dragonboard 845c.

Sometimes things crash, but often the transfers just stop w/o any
obvious error messages.

Initially I thought it was an issue with the HiKey960 dwc3 usb patches
being upstreamed, and was using the following hack workaround:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-5.1&id=dcdadaaec9db7a7b78ea9b838dd1453359a2f388

Then dwc2 added sg support, and I ended up having to revert it to get
by on HiKey:
  https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.1&id=6e91b4c7bd1e94bdd835263403c53e85a677b848

(See thread here: https://lkml.org/lkml/2019/3/8/765)

And now I've reproduced the same issue (with the same dwc3 workaround)
on the already upstream code for Dragonboard 845c.

Fei Yang has also reached out and mentioned he was seeing similar
problems with the f_fs sg support.

Andrzej: Do you have any ideas or suggestions on this? I'm happy to
test or run any debug patches, if it would help narrow the issue down.

If not, should we consider reverting the f_fs sg support?

thanks
-john

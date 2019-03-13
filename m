Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73ABB2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlfZz+QO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfCMCk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 22:40:26 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42940 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCMCk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 22:40:26 -0400
Received: by mail-ot1-f41.google.com with SMTP id i5so385736oto.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XhXZAlnSEma6bLbypon77FfyqhIwSYPYRp4rK/3Hlx8=;
        b=FlfZz+QOO1mlu5eSGd0gul6TDVbc4bgwVqhDRVC+I88SM0FkVfH+5eSldUDJDRqxrN
         0zTIM7rL+W7ea2ocWT+I++adObTqkNa8P7/nHXWKqYfuhceoVIhsRdJqQ/5bpvktKBMP
         k3xzTnmXnedMqYIntSC3gBeai9MBxH4YFVL1Bk5RnjzCXXXH1GGc3bLrKrs/LsB4YCa8
         epswIUkO9u0fB2oaU8vdOl2AXEV5Iin21rtgmp7n2Yt5OZlfJNbJVhduihLqYHsgcXCN
         FdSNXvDYTU/IH/u77OMNnSnY6ZyzELr0auz4g9K3x1cOPxYR5VoCcNygUfUjEt/a0Wn8
         l3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XhXZAlnSEma6bLbypon77FfyqhIwSYPYRp4rK/3Hlx8=;
        b=rooJYSfjqutUNVOEej7PEuEt1qpGYqznRIIyl6ylSWQcLrtsY+YMniQl8NXqnBEXFJ
         BY+G4JxAf1o6xyaqDbHmvXpRcXDgv6RlM58IcljMJaseSZfQr9J/PByHSLA3t5b9fv1Z
         9ns/v5vgPU7KUGWyvzqQp+ZFo1P3MyycrG/Mdan7947A9+1BcZT+gNomrUZAcYEK4v9j
         75RjjXBGDaj4ZYbjfXe+HGM1N9PLRLn1zwOBBB2ApcX2igoWb8m5hi/Vf3sFWyRYYh4D
         SPA86yWr918kebgeTkraoQWYI6EsZ8ATTkt6jTUcQS0OykSJsfMK2kHwSm4IKBD9jC78
         9THg==
X-Gm-Message-State: APjAAAUgb+KwF84SoNyaMTF9LA7DBunRE9O8zKNSfSflVFTl/Jj8zZE8
        83T8TBSD4BY25pTBrqkHyIm9l0CosquAbOe2j0x3I1HxO9s=
X-Google-Smtp-Source: APXvYqzODcjo+MVMFtPmkKK2LIDUzaOPi2COQKsu/RPWDDBFkOxE1CuxMnklx7D2ekd8qv6JpK56mvLrBbO+kBuLUBY=
X-Received: by 2002:a05:6830:1648:: with SMTP id h8mr27338526otr.50.1552444825670;
 Tue, 12 Mar 2019 19:40:25 -0700 (PDT)
MIME-Version: 1.0
From:   Alec Ari <neotheuser@gmail.com>
Date:   Tue, 12 Mar 2019 21:42:01 -0500
Message-ID: <CAM5Ud7N6JYJPtO+4drxj280Xsw-xvnrr2JzB+8gaW4J2CbQS2w@mail.gmail.com>
Subject: Backport Set the CPB bit unconditionally on F17h to 4.14 branch
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request to backport 0237199186e7a4aa5310741f0a6498a20c820fd7 to 4.14 branch

Thanks!

Alec

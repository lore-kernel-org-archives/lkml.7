Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCE5CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3219421D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXsvF7SQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392985AbfJRAee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:34:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41163 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfJRAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:34:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id c17so3536449qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUlu1SWs2RKAwKCxV/9R7y8e+BDWGAAyqQ0an1Lsr9Q=;
        b=OXsvF7SQN+XYVlWUa+QkhyzQlY82oddbjvaFWnStUlidnn51dbg5obEKiaFj5zoc6y
         vwi5qirf6p/I0EprCYIHbJ5s7+dKa9zNJS8Qct/sXCBLvXojZX4N73eeclUdVuTxr2on
         fZXxUG70SWof9y9B7g5dOIsLuBZ7XoEFF9ecWJvzkLQKUHpTID6x+qqIrr18yBuXY8dt
         zYEoKT5bh90GuwYNAIGH9pzHKtKGDQmuA/V53vp9QsYW8ruCmJvctmoiowhBgqny1/H5
         hYvFurEpJdqTOzUYmmTUEqt0V85cGgxkNayG1xlayYRjioTgROxq8AM9L70jMK/3QGEx
         O06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUlu1SWs2RKAwKCxV/9R7y8e+BDWGAAyqQ0an1Lsr9Q=;
        b=j+N6BNNk4XsEQ7RVcpdr5z1enpReWyscdomBpmlUashSVHDq4/fzPS1LoQLjCSZeC+
         aAhbq2kAOHrwqItxmqfAH+yfUiCqtZiAh7MFvrLTIaKxfBGeFO4TRUJckiZ93Ve9K3zM
         B4WJBEDyFWCIpZhIcnXVieUpGjJ3TMJJUTpNWqjGHMhQnbW8hOLMgCh4C6bby/+veJdN
         4jtrQbNtrBRV7oTlgl2+vOAt/iSEof/+DuUid1oQ7bYhyX7ICJzaDHykP3db4g+kiG4b
         fJiE8sphXQcgfkpal9CdTHPt919ptp9FzG9hR48I0mLR6l27RTqk3XNllAGZMAsoMagJ
         kiLw==
X-Gm-Message-State: APjAAAVpcASUpvJ5yJd4MrLJOj1FtnUDG8Qblr5pnDz9lYXBPldXtG09
        uTUHnkCRkLMGuc4H5dWuqU4nnWuIOZaKPg2wo349zsCq7qor
X-Google-Smtp-Source: APXvYqysQ8azqkhvfL+IXNSJUTjI5cgJ7rhGxwOr2jR4+xdknSlXEXLf5ULzXQL+NHfP+CJNDsIennPxYQdpYJ61h60=
X-Received: by 2002:ac8:5147:: with SMTP id h7mr6962616qtn.160.1571358872431;
 Thu, 17 Oct 2019 17:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
In-Reply-To: <20191018001816.94460-1-brendanhiggins@google.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 17:33:56 -0700
Message-ID: <CAAXuY3rLEt9nqOBSNaWjLMHNg6pDHdjtg7hFiYx-KCDhyfnkcg@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        alan.maguire@oracle.com, davidgow@google.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 5:19 PM Brendan Higgins
<brendanhiggins@google.com> wrote:

> +config SECURITY_APPARMOR_TEST
> +       bool "Build KUnit tests for policy_unpack.c"
> +       default n
> +       depends on KUNIT && SECURITY_APPARMOR
> +       help
>
select SECURITY_APPARMOR ?
> +       KUNIT_EXPECT_EQ(test, size, TEST_BLOB_DATA_SIZE);
> +       KUNIT_EXPECT_TRUE(test,
> +               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
I think this must be  KUNIT_ASSERT_EQ(test, size, TEST_BLOB_DATA_SIZE);,
otherwise there could be a buffer overflow in memcmp. All tests that
follow such pattern
are suspect. Also, not sure about your stylistic preference for
KUNIT_EXPECT_TRUE(test,
               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE) == 0);
vs
KUNIT_EXPECT_EQ(test,
               0,
               memcmp(blob, TEST_BLOB_DATA, TEST_BLOB_DATA_SIZE));

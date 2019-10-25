Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7370CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB2D21D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="nPfqDeUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438389AbfJYJSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:18:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfJYJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:18:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so1447493wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vuf33ua9lmBy/pvF4TQMMkf4uhiAiiufvhJM7ldxd14=;
        b=nPfqDeUQakScQa3qQdVWQlWdrGBkrUpwtljmckUp8qUIfIuEX/q803C8AqTUOe86aR
         pZ9IcoRNc9a8qATV5h/rQ8jchLlCJiZ6mbXhr4iRinYlmzbRFb0pbgFbqebImqzo5QMT
         YMWL57Y03bD997nLFiy2nkxK1glwLXHY0PHb77fkYxYHrZ9GU6bTLg2ZF4GLKYAYi0Nw
         OhDMbIY6tSVpAUxkqOtPDjiQvrphwNaSXNzWATpQ3M2BXuq5mBJ4N+gfQM9UH/Z/fMhF
         l98MpT6xb3X/WrPgmXWEeWkNcJKFW2n+l9vaDUiOHdXzGem6g6QMay3gZDag2POVaPPA
         D75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vuf33ua9lmBy/pvF4TQMMkf4uhiAiiufvhJM7ldxd14=;
        b=m95CSUE0H7TOvv2Y4unec+q4hYjaJulz8lwhZlQN2Rhi5gxDZj8qehfUMhWBY4BFSo
         JFEhVUf2OWfOsRL9UtKCQN2YVY4JO06n0W9jceZhAjuQOmkWhhxfDmJfu5xspO9wqQm0
         Ymh83EQUxWZww1BZ2BRTs6WAKTfspBtrS1x8/FVL9F4lJn9WcgdMhHICDoV+Of8FsR2p
         /qKdr7OO/4rHuOvFJFpjtS2f0z1caLXYHflRJyC3+P1cWgalUMSzfL/7kmGLLBFFUgI/
         gifqFUH2I880VbNSOoOt56pID7xW9ul/tblMFkisT6LEo7BKx+ySAF4sWut2DCrUXQkb
         LM0w==
X-Gm-Message-State: APjAAAUJAWASDb/7Z/ofbMzLNVJqAoUqSUG9XLGUDoeElRLhVmEURntQ
        CICdTKlsQ+X5EBICnnUvyf/GvQ==
X-Google-Smtp-Source: APXvYqzd7ql7Px54NVr+8eWYz43YBHQLPqYq9+lilBnGAOqMC9fm4sB2otMmO9RcMc7Rk9L5Dyp0iQ==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr2029985wrs.267.1571995080412;
        Fri, 25 Oct 2019 02:18:00 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id d11sm1781951wrf.80.2019.10.25.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:18:00 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:17:59 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jiri@mellanox.com, idosch@mellanox.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_buffers: remove unneeded
 semicolon
Message-ID: <20191025091759.GC2356@nanopsycho>
References: <20191025090948.13668-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025090948.13668-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Oct 25, 2019 at 11:09:48AM CEST, yuehaibing@huawei.com wrote:
>Remove excess semicolon after closing parenthesis.
>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>

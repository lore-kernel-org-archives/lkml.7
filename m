Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255DEC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AAE21850
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558734042;
	bh=ldm7tYtCNAx0uKydaUxCuFMUCj88o2wcXzFsQTo1K3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xfBy7c0rJml7CiryhUEv7l5TOQ2uS9iLUnK+FPk3cOZJ4kRgai28Tk2Dhi10UTulS
	 82FtmZNvBDttlClhTEamd2s8qh7ylUP5A4eC725gZdn0KydBMEunMrncJHprikckvR
	 IGEaYYlJK+nBv+C8zhVoJ33OrhDGw19AlmF7w0Jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404316AbfEXVkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:40:41 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37282 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:40:41 -0400
Received: by mail-vk1-f195.google.com with SMTP id j124so2545039vkb.4;
        Fri, 24 May 2019 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+M61dggFpUBm+TCSYA6xi0wuFiDoyPhijq/BdxGIPBk=;
        b=KkoOGgzCIRobqWvnIcfEZiben3HUa1XuJPtePp0Fmv0tK7T+s/bXdCY3CgTdQoanWp
         vJbJXh2IIyXXJW1N5krN9UdUMiz3YkwTDzz2NY5cXDNOSk8KmMWLeAo3/y7l8nEliot1
         HMIr7kLIvhW/C4B2PUYUgSQgsr6Lem76Ef1hnRGRJMHmmqwFeRUEeuSM81t6aLa/yWpw
         3Y0iOBZVkQeFv/Wbe6W18wXw5Vyc9lkjPa8o/yCIyrVVvQClK5sbOh/QdpoEiEFPtUaT
         pV4Pvh9403nTNfRkbI/CIJpNGnZHeWHe5Mt2D4X8pGBHEKo1h3WdwpSzdOzMgfev9GWI
         3o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+M61dggFpUBm+TCSYA6xi0wuFiDoyPhijq/BdxGIPBk=;
        b=Gnv6kbHR21hYllzjnBTd62fBT1jNN5sO9fCub4ZikVNlYQb8jUN+LQL0GAwOwpfQqF
         Squ6h+tE4cijE+2dxbOwuSkivyTZspru0PvY+39QZBEII9Q8hFs+UTeule0j8TumvB6F
         xwHVEjWig3h45PnRJZkd4F6H1kwky87AGGFHsfPiGtcLQvsV0ZXT+qLwccpYmYY+tC8J
         auImPkRKxnA1E/1lz1xY2mYr4OWdRK0yjlW+LN2jpRFcmWy/wSyT2OV/w+mHV8KvYVzk
         F0W6ji+ww+QbJbm9lLWIKGQPsePg8q2pxqlPE817LFxMnVeXnNI1cx6pFp6ycf9BP1sB
         qoHA==
X-Gm-Message-State: APjAAAXYTeACOZv4r52VRpIPNqdjed1AKu0Izk8G740kV64Ha9BVGDYE
        OjrEftEQSgET0+36HVO+ex8=
X-Google-Smtp-Source: APXvYqy7ExThNB8MzXNF1tcEeF+YKb4KPnI+iUe0LLM8xq5AJ9GFWsibPXr7oV0Z3SNqZVt4cZ/CWg==
X-Received: by 2002:a1f:24c4:: with SMTP id k187mr8034744vkk.26.1558734039565;
        Fri, 24 May 2019 14:40:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:36ab])
        by smtp.gmail.com with ESMTPSA id b10sm1842702vke.46.2019.05.24.14.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:40:38 -0700 (PDT)
Date:   Fri, 24 May 2019 14:40:35 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] kselftest/cgroup: fix unexpected testing failure
 on test_memcontrol
Message-ID: <20190524214035.GG374014@devbig004.ftw2.facebook.com>
References: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
 <20190520030140.203605-2-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520030140.203605-2-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

All three patches look good to me.  Please feel free to add my
acked-by.  Shuah, should I route these through cgroup tree or would
the kselftest tree be a better fit?

Thanks.

-- 
tejun

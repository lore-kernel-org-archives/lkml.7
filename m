Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75322C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447B1206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 18:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="s7dw+u4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfJLSTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 14:19:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45986 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfJLSTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 14:19:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so6461581pgj.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BrHOsSRcDL7aWUfLwD9kPI6jS/4VpGhGV49UFuwLV8I=;
        b=s7dw+u4OawZUh3UkaKX5efxRZ9p3Hx7gHqw16PNnnhYdCyiIiMjR/iM8y7fpffJ4Ku
         fcCJgHLtcFB+DoN/rFr6Mnx4g0l2ggUPjHxWeYiPvrTX0SRgtVuVF1ikKC+oLtgivpEr
         UAFSRAQRJsG9slS7W4v1SX/P1kbA+XLBNkpZ73ULSMzNbnmVMHp5GNBTFM/bDPiYsql+
         gHN5rNAyg2qX8GBICCHj/fSyLcnYho+jTz/WywrcWIiXyO9tquF6kzJZ7kKfvVP/XOLH
         QDCMCCoi7KYIrhzWF8Byd2J6xo4ULjrb3x/5UTLcTdRpPOSvGK6errQHaYJOQYnVXesW
         TyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BrHOsSRcDL7aWUfLwD9kPI6jS/4VpGhGV49UFuwLV8I=;
        b=kvrecGvyZ3d9T71TPn2M1REtaRyABJyH5PXgr6/9ne4DKJFWfkKsEnD2ao2V8KHwsX
         HqVy2zg57lUb9Ljqah0hryrod9seNSq2NXKydYMlqtinY6ZJrEshBJ/0wv6ThTrX1G3/
         hWUkaMl25H7CEpoX9yvTiK05bjFcc3V03lh7LDoLc90o7WwVB6WEQEUDx9FE983rDYYi
         eFAdk4cGndAZoim+jP2OKoBqyxqetr112LyTvHgdWOeZC2gBPQn+dzWUs0z6LwyPlYrX
         Wi96m4mfVz4+KRR18/9CZCdqjzngVkbiZwaNcf7MdSyndqEPwX2UvjB3I4XPSTWIUwNc
         3CBA==
X-Gm-Message-State: APjAAAXXwQUtVVks9FSGPMS0+4XqKkic0PJsnN6RZ4JaJE+ow9JOUwKk
        PdCuyjOYwOr/uwzA+0Nq6EVTKA==
X-Google-Smtp-Source: APXvYqwZyEL7Z/qE59P63rEjwl7wv196Mvbm2dQsDja4cYaYj9UxDPcxT0WHnoj6xx5lFpAMHiiNGw==
X-Received: by 2002:a65:5345:: with SMTP id w5mr15242249pgr.213.1570904349926;
        Sat, 12 Oct 2019 11:19:09 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id h8sm13614914pfo.64.2019.10.12.11.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2019 11:19:09 -0700 (PDT)
Subject: Re: drivers/net/ethernet/pensando/ionic/ionic_lif.c:333:2: error:
 implicit declaration of function 'dynamic_hex_dump'; did you mean
 'seq_hex_dump'?
To:     kbuild test robot <lkp@intel.com>,
        David Miller <davem@davemloft.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <201910130127.4lO6Z6uy%lkp@intel.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <f88f6b41-0bd2-e078-5286-855995381214@pensando.io>
Date:   Sat, 12 Oct 2019 11:19:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201910130127.4lO6Z6uy%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/19 10:45 AM, kbuild test robot wrote:
> Hi Shannon,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a
> commit: 77ceb68e29ccd25d923b6af59e74ecaf736cc4b7 ionic: Add notifyq support
> date:   5 weeks ago
> config: x86_64-randconfig-a002-201941 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>          git checkout 77ceb68e29ccd25d923b6af59e74ecaf736cc4b7
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

Hmmm, I thought Arnd Bergmann had already addressed these, and I Acked:

https://lore.kernel.org/netdev/91b69922-926a-9c27-3a08-e2db2d7ea66f@pensando.io/

Dave, is there something more I need to do here?

sln


>
> All errors (new ones prefixed by >>):
>
>     drivers/net/ethernet/pensando/ionic/ionic_lif.c: In function 'ionic_notifyq_service':
>>> drivers/net/ethernet/pensando/ionic/ionic_lif.c:333:2: error: implicit declaration of function 'dynamic_hex_dump'; did you mean 'seq_hex_dump'? [-Werror=implicit-function-declaration]
>       dynamic_hex_dump("event ", DUMP_PREFIX_OFFSET, 16, 1,
>       ^~~~~~~~~~~~~~~~
>       seq_hex_dump
>     cc1: some warnings being treated as errors
>
> vim +333 drivers/net/ethernet/pensando/ionic/ionic_lif.c
>
>     311	
>     312	static bool ionic_notifyq_service(struct ionic_cq *cq,
>     313					  struct ionic_cq_info *cq_info)
>     314	{
>     315		union ionic_notifyq_comp *comp = cq_info->cq_desc;
>     316		struct net_device *netdev;
>     317		struct ionic_queue *q;
>     318		struct ionic_lif *lif;
>     319		u64 eid;
>     320	
>     321		q = cq->bound_q;
>     322		lif = q->info[0].cb_arg;
>     323		netdev = lif->netdev;
>     324		eid = le64_to_cpu(comp->event.eid);
>     325	
>     326		/* Have we run out of new completions to process? */
>     327		if (eid <= lif->last_eid)
>     328			return false;
>     329	
>     330		lif->last_eid = eid;
>     331	
>     332		dev_dbg(lif->ionic->dev, "notifyq event:\n");
>   > 333		dynamic_hex_dump("event ", DUMP_PREFIX_OFFSET, 16, 1,
>     334				 comp, sizeof(*comp), true);
>     335	
>     336		switch (le16_to_cpu(comp->event.ecode)) {
>     337		case IONIC_EVENT_LINK_CHANGE:
>     338			netdev_info(netdev, "Notifyq IONIC_EVENT_LINK_CHANGE eid=%lld\n",
>     339				    eid);
>     340			netdev_info(netdev,
>     341				    "  link_status=%d link_speed=%d\n",
>     342				    le16_to_cpu(comp->link_change.link_status),
>     343				    le32_to_cpu(comp->link_change.link_speed));
>     344			break;
>     345		case IONIC_EVENT_RESET:
>     346			netdev_info(netdev, "Notifyq IONIC_EVENT_RESET eid=%lld\n",
>     347				    eid);
>     348			netdev_info(netdev, "  reset_code=%d state=%d\n",
>     349				    comp->reset.reset_code,
>     350				    comp->reset.state);
>     351			break;
>     352		default:
>     353			netdev_warn(netdev, "Notifyq unknown event ecode=%d eid=%lld\n",
>     354				    comp->event.ecode, eid);
>     355			break;
>     356		}
>     357	
>     358		return true;
>     359	}
>     360	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


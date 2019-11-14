Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B641C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C158206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKNA4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:56:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:32673 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKNA4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:56:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 16:56:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="229945479"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2019 16:56:06 -0800
Subject: Re: [kbuild-all] Re: [PATCH 3/3] platform: chrome: Added
 cros-ec-typec driver
To:     Jon Flatley <jflat@chromium.org>, kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>, groeck@chromium.org,
        sre@kernel.org
References: <20191113031044.136232-4-jflat@chromium.org>
 <201911132033.3UoCbltt%lkp@intel.com>
 <CACJJ=pzyn2DX0fcAjzNs-ZXMByt=GcH5005+Ki28uoW1AeQ-yg@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <10ca6424-26bb-54b6-ea67-c782ebfb6813@intel.com>
Date:   Thu, 14 Nov 2019 08:55:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACJJ=pzyn2DX0fcAjzNs-ZXMByt=GcH5005+Ki28uoW1AeQ-yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/19 1:23 AM, Jon Flatley wrote:
> On Wed, Nov 13, 2019 at 4:55 AM kbuild test robot <lkp@intel.com> wrote:
>> Hi Jon,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on ljones-mfd/for-mfd-next]
>> [cannot apply to v5.4-rc7 next-20191113]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Jon-Flatley/ChromeOS-EC-USB-C-Connector-Class/20191113-193504
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>>
>> coccinelle warnings: (new ones prefixed by >>)
>>
>>>> drivers/platform/chrome/cros_ec_typec.c:223:9-16: ERROR: PTR_ERR applied after initialization to constant on line 222
>> vim +223 drivers/platform/chrome/cros_ec_typec.c
>>
>>     206
>>     207  static int cros_typec_add_partner(struct typec_data *typec, int port_num,
>>     208                  bool pd_enabled)
>>     209  {
>>     210          struct port_data *port;
>>     211          struct typec_partner_desc p_desc;
>>     212          int ret;
>>     213
>>     214          port = typec->ports[port_num];
>>     215          p_desc.usb_pd = pd_enabled;
>>     216          p_desc.identity = &port->p_identity;
>>     217
>>     218          port->partner = typec_register_partner(port->port, &p_desc);
>>     219          if (IS_ERR_OR_NULL(port->partner)) {
>>     220                  dev_err(typec->dev, "Port %d partner register failed\n",
>>     221                                  port_num);
>>   > 222                  port->partner = NULL;
>>   > 223                  return PTR_ERR(port->partner);
>>     224          }
>>     225
>>     226          ret = cros_typec_query_pd_info(typec, port_num);
>>     227          if (ret < 0) {
>>     228                  dev_err(typec->dev, "Port %d PD query failed\n", port_num);
>>     229                  typec_unregister_partner(port->partner);
>>     230                  port->partner = NULL;
>>     231                  return ret;
>>     232          }
>>     233
>>     234          ret = typec_partner_set_identity(port->partner);
>>     235          return ret;
>>     236  }
>>     237
>>
>> ---
>> 0-DAY kernel test infrastructure                 Open Source Technology Center
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> This patch is based off of the chrome-platform for-next branch.
>
> base: https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
> for-next
>
> Is this incorrect? I'm happy to rebase if necessary.
>
> Thanks,
> -Jon

Hi Jon,

Thanks for the response, we'll fix the wrong base ASAP.

Best Regards,
Rong Chen

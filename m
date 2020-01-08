Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F54DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA46420720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgAHQyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:54:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:12929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729015AbgAHQyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:54:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="233668253"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2020 08:54:46 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ipEbW-0005dL-CG; Wed, 08 Jan 2020 18:54:46 +0200
Date:   Wed, 8 Jan 2020 18:54:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/36] platform/x86: intel_telemetry: Convert to use
 new SCU IPC API
Message-ID: <20200108165446.GO32742@smile.fi.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
 <20200108114201.27908-30-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108114201.27908-30-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:54PM +0300, Mika Westerberg wrote:
> Convert the Intel Apollo Lake telemetry driver to use the new SCU IPC
> API. This allows us to get rid of the duplicate PMC IPC implementation
> which is now covered in SCU IPC driver.
> 
> Also move telemetry specific IPC message constant to the telementry
> driver where it belongs.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h          |   1 -
>  arch/x86/include/asm/intel_telemetry.h        |   3 +
>  drivers/platform/x86/intel_telemetry_pltdrv.c | 101 +++++++++---------
>  3 files changed, 55 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
> index b438a488f613..ddc964b9c78c 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -8,7 +8,6 @@
>  #define PMC_IPC_PHY_CONFIG		0xEE
>  #define PMC_IPC_NORTHPEAK_CTRL		0xED
>  #define PMC_IPC_PM_DEBUG		0xEC
> -#define PMC_IPC_PMC_TELEMTRY		0xEB
>  #define PMC_IPC_PMC_FW_MSG_CTRL		0xEA
>  
>  /* IPC return code */
> diff --git a/arch/x86/include/asm/intel_telemetry.h b/arch/x86/include/asm/intel_telemetry.h
> index 214394860632..e19deb776003 100644
> --- a/arch/x86/include/asm/intel_telemetry.h
> +++ b/arch/x86/include/asm/intel_telemetry.h
> @@ -10,6 +10,8 @@
>  #define TELEM_MAX_EVENTS_SRAM		28
>  #define TELEM_MAX_OS_ALLOCATED_EVENTS	20
>  
> +#include <asm/intel_scu_ipc.h>
> +
>  enum telemetry_unit {
>  	TELEM_PSS = 0,
>  	TELEM_IOSS,
> @@ -54,6 +56,7 @@ struct telemetry_plt_config {
>  	struct telemetry_unit_config ioss_config;
>  	struct mutex telem_trace_lock;
>  	struct mutex telem_lock;
> +	struct intel_scu_ipc_dev *scu;
>  	bool telem_in_use;
>  };
>  
> diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
> index df8565bad595..d39dde634866 100644
> --- a/drivers/platform/x86/intel_telemetry_pltdrv.c
> +++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
> @@ -15,7 +15,6 @@
>  
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> -#include <asm/intel_pmc_ipc.h>
>  #include <asm/intel_punit_ipc.h>
>  #include <asm/intel_telemetry.h>
>  
> @@ -35,6 +34,7 @@
>  #define TELEM_SSRAM_STARTTIME_OFFSET	8
>  #define TELEM_SSRAM_EVTLOG_OFFSET	16
>  
> +#define IOSS_TELEM			0xeb
>  #define IOSS_TELEM_EVENT_READ		0x0
>  #define IOSS_TELEM_EVENT_WRITE		0x1
>  #define IOSS_TELEM_INFO_READ		0x2
> @@ -42,9 +42,6 @@
>  #define IOSS_TELEM_TRACE_CTL_WRITE	0x6
>  #define IOSS_TELEM_EVENT_CTL_READ	0x7
>  #define IOSS_TELEM_EVENT_CTL_WRITE	0x8
> -#define IOSS_TELEM_EVT_CTRL_WRITE_SIZE	0x4
> -#define IOSS_TELEM_READ_WORD		0x1
> -#define IOSS_TELEM_WRITE_FOURBYTES	0x4
>  #define IOSS_TELEM_EVT_WRITE_SIZE	0x3
>  
>  #define TELEM_INFO_SRAMEVTS_MASK	0xFF00
> @@ -253,17 +250,14 @@ static int telemetry_check_evtid(enum telemetry_unit telem_unit,
>  static inline int telemetry_plt_config_ioss_event(u32 evt_id, int index)
>  {
>  	u32 write_buf;
> -	int ret;
>  
>  	write_buf = evt_id | TELEM_EVENT_ENABLE;
>  	write_buf <<= BITS_PER_BYTE;
>  	write_buf |= index;
>  
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				    IOSS_TELEM_EVENT_WRITE, (u8 *)&write_buf,
> -				    IOSS_TELEM_EVT_WRITE_SIZE, NULL, 0);
> -
> -	return ret;
> +	return intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
> +					 IOSS_TELEM_EVENT_WRITE, &write_buf,
> +					 IOSS_TELEM_EVT_WRITE_SIZE, NULL, 0);
>  }
>  
>  static inline int telemetry_plt_config_pss_event(u32 evt_id, int index)
> @@ -281,6 +275,7 @@ static inline int telemetry_plt_config_pss_event(u32 evt_id, int index)
>  static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
>  					 enum telemetry_action action)
>  {
> +	struct intel_scu_ipc_dev *scu = telm_conf->scu;
>  	u8 num_ioss_evts, ioss_period;
>  	int ret, index, idx;
>  	u32 *ioss_evtmap;
> @@ -291,9 +286,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
>  	ioss_evtmap = evtconfig.evtmap;
>  
>  	/* Get telemetry EVENT CTL */
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> +	ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
>  				    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
> -				    &telem_ctrl, IOSS_TELEM_READ_WORD);
> +				    &telem_ctrl, sizeof(telem_ctrl));
>  	if (ret) {
>  		pr_err("IOSS TELEM_CTRL Read Failed\n");
>  		return ret;
> @@ -302,11 +297,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
>  	/* Disable Telemetry */
>  	TELEM_DISABLE(telem_ctrl);
>  
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				    IOSS_TELEM_EVENT_CTL_WRITE,
> -				    (u8 *)&telem_ctrl,
> -				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -				    NULL, 0);
> +	ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
> +				    IOSS_TELEM_EVENT_CTL_WRITE, &telem_ctrl,
> +				    sizeof(telem_ctrl), NULL, 0);
>  	if (ret) {
>  		pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
>  		return ret;
> @@ -318,10 +311,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
>  		/* Clear All Events */
>  		TELEM_CLEAR_EVENTS(telem_ctrl);
>  
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> +		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
>  					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> +					    &telem_ctrl, sizeof(telem_ctrl),
>  					    NULL, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
> @@ -347,10 +339,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
>  		/* Clear All Events */
>  		TELEM_CLEAR_EVENTS(telem_ctrl);
>  
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> +		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
>  					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> +					    &telem_ctrl, sizeof(telem_ctrl),
>  					    NULL, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
> @@ -399,10 +390,9 @@ static int telemetry_setup_iossevtconfig(struct telemetry_evtconfig evtconfig,
>  	TELEM_ENABLE_PERIODIC(telem_ctrl);
>  	telem_ctrl |= ioss_period;
>  
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> +	ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
>  				    IOSS_TELEM_EVENT_CTL_WRITE,
> -				    (u8 *)&telem_ctrl,
> -				    IOSS_TELEM_EVT_CTRL_WRITE_SIZE, NULL, 0);
> +				    &telem_ctrl, sizeof(telem_ctrl), NULL, 0);
>  	if (ret) {
>  		pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
>  		return ret;
> @@ -589,8 +579,9 @@ static int telemetry_setup(struct platform_device *pdev)
>  	u32 read_buf, events, event_regs;
>  	int ret;
>  
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY, IOSS_TELEM_INFO_READ,
> -				    NULL, 0, &read_buf, IOSS_TELEM_READ_WORD);
> +	ret = intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
> +					IOSS_TELEM_INFO_READ, NULL, 0,
> +					&read_buf, sizeof(read_buf));
>  	if (ret) {
>  		dev_err(&pdev->dev, "IOSS TELEM_INFO Read Failed\n");
>  		return ret;
> @@ -684,6 +675,8 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
>  
>  	mutex_lock(&(telm_conf->telem_lock));
>  	if (ioss_period) {
> +		struct intel_scu_ipc_dev *scu = telm_conf->scu;
> +
>  		if (TELEM_SAMPLE_PERIOD_INVALID(ioss_period)) {
>  			pr_err("IOSS Sampling Period Out of Range\n");
>  			ret = -EINVAL;
> @@ -691,9 +684,9 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
>  		}
>  
>  		/* Get telemetry EVENT CTL */
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> +		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
>  					    IOSS_TELEM_EVENT_CTL_READ, NULL, 0,
> -					    &telem_ctrl, IOSS_TELEM_READ_WORD);
> +					    &telem_ctrl, sizeof(telem_ctrl));
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Read Failed\n");
>  			goto out;
> @@ -702,11 +695,10 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
>  		/* Disable Telemetry */
>  		TELEM_DISABLE(telem_ctrl);
>  
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -					    NULL, 0);
> +		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
> +						IOSS_TELEM_EVENT_CTL_WRITE,
> +						&telem_ctrl, sizeof(telem_ctrl),
> +						NULL, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Disable Write Failed\n");
>  			goto out;
> @@ -718,11 +710,10 @@ static int telemetry_plt_set_sampling_period(u8 pss_period, u8 ioss_period)
>  		TELEM_ENABLE_PERIODIC(telem_ctrl);
>  		telem_ctrl |= ioss_period;
>  
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -					    IOSS_TELEM_EVENT_CTL_WRITE,
> -					    (u8 *)&telem_ctrl,
> -					    IOSS_TELEM_EVT_CTRL_WRITE_SIZE,
> -					    NULL, 0);
> +		ret = intel_scu_ipc_dev_command(scu, IOSS_TELEM,
> +						IOSS_TELEM_EVENT_CTL_WRITE,
> +						&telem_ctrl, sizeof(telem_ctrl),
> +						NULL, 0);
>  		if (ret) {
>  			pr_err("IOSS TELEM_CTRL Event Enable Write Failed\n");
>  			goto out;
> @@ -1017,9 +1008,9 @@ static int telemetry_plt_get_trace_verbosity(enum telemetry_unit telem_unit,
>  		break;
>  
>  	case TELEM_IOSS:
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				IOSS_TELEM_TRACE_CTL_READ, NULL, 0, &temp,
> -				IOSS_TELEM_READ_WORD);
> +		ret = intel_scu_ipc_dev_command(telm_conf->scu,
> +				IOSS_TELEM, IOSS_TELEM_TRACE_CTL_READ,
> +				NULL, 0, &temp, sizeof(temp));
>  		if (ret) {
>  			pr_err("IOSS TRACE_CTL Read Failed\n");
>  			goto out;
> @@ -1071,9 +1062,9 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
>  		break;
>  
>  	case TELEM_IOSS:
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				IOSS_TELEM_TRACE_CTL_READ, NULL, 0, &temp,
> -				IOSS_TELEM_READ_WORD);
> +		ret = intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
> +						IOSS_TELEM_TRACE_CTL_READ,
> +						NULL, 0, &temp, sizeof(temp));
>  		if (ret) {
>  			pr_err("IOSS TRACE_CTL Read Failed\n");
>  			goto out;
> @@ -1082,9 +1073,9 @@ static int telemetry_plt_set_trace_verbosity(enum telemetry_unit telem_unit,
>  		TELEM_CLEAR_VERBOSITY_BITS(temp);
>  		TELEM_SET_VERBOSITY_BITS(temp, verbosity);
>  
> -		ret = intel_pmc_ipc_command(PMC_IPC_PMC_TELEMTRY,
> -				IOSS_TELEM_TRACE_CTL_WRITE, (u8 *)&temp,
> -				IOSS_TELEM_WRITE_FOURBYTES, NULL, 0);
> +		ret = intel_scu_ipc_dev_command(telm_conf->scu, IOSS_TELEM,
> +						IOSS_TELEM_TRACE_CTL_WRITE,
> +						&temp, sizeof(temp), NULL, 0);
>  		if (ret) {
>  			pr_err("IOSS TRACE_CTL Verbosity Set Failed\n");
>  			goto out;
> @@ -1172,6 +1163,12 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	telm_conf->scu = intel_scu_ipc_dev_get();
> +	if (!telm_conf->scu) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
>  	mutex_init(&telm_conf->telem_lock);
>  	mutex_init(&telm_conf->telem_trace_lock);
>  
> @@ -1196,6 +1193,10 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
>  		iounmap(telm_conf->pss_config.regmap);
>  	if (telm_conf->ioss_config.regmap)
>  		iounmap(telm_conf->ioss_config.regmap);
> +	if (telm_conf->scu) {
> +		intel_scu_ipc_dev_put(telm_conf->scu);
> +		telm_conf->scu = NULL;
> +	}
>  	dev_err(&pdev->dev, "TELEMETRY Setup Failed.\n");
>  
>  	return ret;
> @@ -1204,6 +1205,8 @@ static int telemetry_pltdrv_probe(struct platform_device *pdev)
>  static int telemetry_pltdrv_remove(struct platform_device *pdev)
>  {
>  	telemetry_clear_pltdata();
> +	intel_scu_ipc_dev_put(telm_conf->scu);
> +	telm_conf->scu = NULL;
>  	iounmap(telm_conf->pss_config.regmap);
>  	iounmap(telm_conf->ioss_config.regmap);
>  
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko



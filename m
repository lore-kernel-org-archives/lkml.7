Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252B5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E35213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="er1KuzqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfFXLoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:44:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44588 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfFXLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:44:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190624114414euoutp029e813bdc065d4a3bd4cb25f293548d7d~rH8t8_XBm1186811868euoutp02z
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:44:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190624114414euoutp029e813bdc065d4a3bd4cb25f293548d7d~rH8t8_XBm1186811868euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561376654;
        bh=OQuH1fK1Mq0SGuvaIWVkirqd0DzLaLERGnAwyc1o0PY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=er1KuzqMKjogbSSN/ncKmxXFac2P4zHRbKvPdpBJbPRnXUs0F0g78nX13ZIis1dcr
         r9REnilXvMpxPZRYpC+OLIUwhYzizwCURiGANBkX0wTMpQvgSzMSZ4PIqyK4QPIath
         GXRc4iHIT30ZcLqtisiWMVTnSHiSnZzeIquQZ1FQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190624114413eucas1p1953e70c97577b65ac95759ec5c500cd7~rH8tQUVMY0606206062eucas1p17;
        Mon, 24 Jun 2019 11:44:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DC.3A.04377.D87B01D5; Mon, 24
        Jun 2019 12:44:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190624114413eucas1p14fcfcf4feb2a1458f02be3414f6cd57c~rH8sj2g6d1682016820eucas1p1C;
        Mon, 24 Jun 2019 11:44:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190624114413eusmtrp15bf14aef47ac2a8b297228048339e64e~rH8sjQ-Ur2161521615eusmtrp1K;
        Mon, 24 Jun 2019 11:44:13 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-be-5d10b78d24e6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8A.13.04140.D87B01D5; Mon, 24
        Jun 2019 12:44:13 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190624114412eusmtip12a0b55ea36d2b276144f305eca20696b~rH8sHK0C20194001940eusmtip1I;
        Mon, 24 Jun 2019 11:44:12 +0000 (GMT)
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: Allow VPG to be enabled
 via debugfs
To:     Matt Redfearn <matt.redfearn@thinci.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d73e0df8-761d-380c-17f3-f3cbb737c677@samsung.com>
Date:   Mon, 24 Jun 2019 13:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fd4f3c69-5bbd-a7ac-983c-4aa9a2a2313e@thinci.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djP87q92wViDf7MVrfoPXeSyaKp4y2r
        xZWv79ksOicuYbe4vGsOm8Wu+wuYLLbP28BksfT3O0aLBy0vWC3aO1vZHLg8Lvf1MnnM7pjJ
        6rH92wNWj/vdx5k8/s7az+Lx9MdeZo/Zkx+xenzeJBfAEcVlk5Kak1mWWqRvl8CV8XTPQqaC
        GRoV81+4NjAeVehi5OCQEDCRmLpcsYuRi0NIYAWjxKmXk9ggnC+MEst+LWaHcD4zSjz+fZGp
        i5ETrKN7zlmoquWMEq0thxlBEkICbxkljhz2A7GFBcIlHlzqYwUpEhHoY5Q4NuUNM4jDLHCT
        SeLntwdgHWwCmhJ/N99kA7F5Bewkvn6aBmazCKhKPH27iBnEFhWIkPiycxMjRI2gxMmZT1hA
        bE6g+u/35oPZzALyEs1bZzND2OISt57MZwJZJiFwj11i77LTUHe7SJxdt4gVwhaWeHV8CzuE
        LSNxenIPC4RdL3F/RQszRHMHo8TWDTuZIRLWEoePX2QFBRkz0NXrd+lDhB0l9n9cxAgJST6J
        G28FIW7gk5i0bTozRJhXoqNNCKJaUeL+2a1QA8Ulll74yjaBUWkWks9mIflmFpJvZiHsXcDI
        sopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwfZ3+d/zLDsZdf5IOMQpwMCrx8Aps4I8V
        Yk0sK67MPcQowcGsJMK7NFEgVog3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU
        1ILUIpgsEwenVANj/r/giZ9dd9iLJgXyCZjE3+Ta4Fq65aGI1dIne9MZDh1KLuC3vfjDTjk/
        tumY2MrHMma7xXS9rJep7YlP3qmn9ndbcNL58Evih25k3CtrzNjzWnodn3jaZ/vDd/fdmb3Q
        kuu3f6TQ0oui97tmx2VKe4u8eMhQUXbvAtOM2x8Ewx/GzOzNjuRUYinOSDTUYi4qTgQAohK5
        EVsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7q92wViDc5tYrfoPXeSyaKp4y2r
        xZWv79ksOicuYbe4vGsOm8Wu+wuYLLbP28BksfT3O0aLBy0vWC3aO1vZHLg8Lvf1MnnM7pjJ
        6rH92wNWj/vdx5k8/s7az+Lx9MdeZo/Zkx+xenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRn
        aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8XTPQqaCGRoV81+4NjAeVehi5OSQEDCR
        6J5zlq2LkYtDSGApo8Sprd2sEAlxid3z3zJD2MISf651QRW9ZpSY8/wsO0hCWCBcor23jREk
        ISLQxyix4OAXdhCHWeA2k8Ts748YQaqEBL4ySpw9EQFiswloSvzdfJMNxOYVsJP4+mkamM0i
        oCrx9O0isHWiAhESs3c1sEDUCEqcnPkEzOYEqv9+bz6YzSygLvFn3iVmCFteonnrbChbXOLW
        k/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNltx35u
        2cHY9S74EKMAB6MSD6/ABv5YIdbEsuLK3EOMEhzMSiK8SxMFYoV4UxIrq1KL8uOLSnNSiw8x
        mgI9N5FZSjQ5H5hO8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1
        MPp9saq5mR+huu2wvuI8Dm7jWU8UzMxWa2zezK5scnXz4uMvnRLP28+clxh2s+nGUqmmDINl
        DCfn9Ees6ctZtZGDOffLe80zHSs7jVjPXLZasOqp2LNrYn2cqy6a3Tfvk993o0Rt2kfVZ5W6
        86V++P6p7//raXo14qThhqOuwmJTS87/DGXcba3EUpyRaKjFXFScCADmrb7Z7wIAAA==
X-CMS-MailID: 20190624114413eucas1p14fcfcf4feb2a1458f02be3414f6cd57c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190624110224epcas3p45442d82c6f6c3e99311334c2603b9143
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190624110224epcas3p45442d82c6f6c3e99311334c2603b9143
References: <20190430081646.23845-1-matt.redfearn@thinci.com>
        <0832ec0c-cf21-7b43-17a7-dbe54513453c@st.com>
        <CGME20190624110224epcas3p45442d82c6f6c3e99311334c2603b9143@epcas3p4.samsung.com>
        <fd4f3c69-5bbd-a7ac-983c-4aa9a2a2313e@thinci.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.06.2019 13:02, Matt Redfearn wrote:
> Hi,
> Anything stopping this being applied?


Queued to drm-misc-next.

--
Regards
Andrzej


>
> Thanks,
> Matt
>
> On 03/05/2019 16:32, Philippe CORNU wrote:
>> Hi Matt,
>> and many thanks for the patch.
>>
>> Tested successfully by Yannick on STM32MP1 boards :-)
>>
>> Tested-by: Yannick Fertré <yannick.fertre@st.com>
>> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
>>
>> Thank you,
>> Philippe :-)
>>
>>
>> On 4/30/19 10:17 AM, Matt Redfearn wrote:
>>> The Synopsys MIPI DSI IP contains a video test pattern generator which
>>> is helpful in debugging video timing with connected displays.
>>> Add a debugfs directory containing files which allow the VPG to be
>>> enabled and disabled, and its orientation to be changed.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Ensure dw_mipi_dsi_video_mode_config() doesn't break without CONFIG_DEBUG_FS
>>> - Tidy up initialisation / tidy up of debugfs
>>>
>>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 47 +++++++++++++++++++
>>>    1 file changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> index 0ee440216b8..bffeef7a6cc 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> @@ -10,6 +10,7 @@
>>>    
>>>    #include <linux/clk.h>
>>>    #include <linux/component.h>
>>> +#include <linux/debugfs.h>
>>>    #include <linux/iopoll.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of_device.h>
>>> @@ -86,6 +87,8 @@
>>>    #define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
>>>    #define VID_MODE_TYPE_BURST			0x2
>>>    #define VID_MODE_TYPE_MASK			0x3
>>> +#define VID_MODE_VPG_ENABLE		BIT(16)
>>> +#define VID_MODE_VPG_HORIZONTAL		BIT(24)
>>>    
>>>    #define DSI_VID_PKT_SIZE		0x3c
>>>    #define VID_PKT_SIZE(p)			((p) & 0x3fff)
>>> @@ -234,6 +237,13 @@ struct dw_mipi_dsi {
>>>    	u32 format;
>>>    	unsigned long mode_flags;
>>>    
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	struct dentry *debugfs;
>>> +
>>> +	bool vpg;
>>> +	bool vpg_horizontal;
>>> +#endif /* CONFIG_DEBUG_FS */
>>> +
>>>    	struct dw_mipi_dsi *master; /* dual-dsi master ptr */
>>>    	struct dw_mipi_dsi *slave; /* dual-dsi slave ptr */
>>>    
>>> @@ -525,6 +535,13 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
>>>    	else
>>>    		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
>>>    
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	if (dsi->vpg) {
>>> +		val |= VID_MODE_VPG_ENABLE;
>>> +		val |= dsi->vpg_horizontal ? VID_MODE_VPG_HORIZONTAL : 0;
>>> +	}
>>> +#endif /* CONFIG_DEBUG_FS */
>>> +
>>>    	dsi_write(dsi, DSI_VID_MODE_CFG, val);
>>>    }
>>>    
>>> @@ -935,6 +952,33 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
>>>    	.attach	      = dw_mipi_dsi_bridge_attach,
>>>    };
>>>    
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>> +static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	dsi->debugfs = debugfs_create_dir(dev_name(dsi->dev), NULL);
>>> +	if (IS_ERR(dsi->debugfs)) {
>>> +		dev_err(dsi->dev, "failed to create debugfs root\n");
>>> +		return;
>>> +	}
>>> +
>>> +	debugfs_create_bool("vpg", 0660, dsi->debugfs, &dsi->vpg);
>>> +	debugfs_create_bool("vpg_horizontal", 0660, dsi->debugfs,
>>> +			    &dsi->vpg_horizontal);
>>> +}
>>> +
>>> +static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi)
>>> +{
>>> +	debugfs_remove_recursive(dsi->debugfs);
>>> +}
>>> +
>>> +#else
>>> +
>>> +static void dw_mipi_dsi_debugfs_init(struct dw_mipi_dsi *dsi) { }
>>> +static void dw_mipi_dsi_debugfs_remove(struct dw_mipi_dsi *dsi) { }
>>> +
>>> +#endif /* CONFIG_DEBUG_FS */
>>> +
>>>    static struct dw_mipi_dsi *
>>>    __dw_mipi_dsi_probe(struct platform_device *pdev,
>>>    		    const struct dw_mipi_dsi_plat_data *plat_data)
>>> @@ -1005,6 +1049,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>>>    		clk_disable_unprepare(dsi->pclk);
>>>    	}
>>>    
>>> +	dw_mipi_dsi_debugfs_init(dsi);
>>>    	pm_runtime_enable(dev);
>>>    
>>>    	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
>>> @@ -1012,6 +1057,7 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>>>    	ret = mipi_dsi_host_register(&dsi->dsi_host);
>>>    	if (ret) {
>>>    		dev_err(dev, "Failed to register MIPI host: %d\n", ret);
>>> +		dw_mipi_dsi_debugfs_remove(dsi);
>>>    		return ERR_PTR(ret);
>>>    	}
>>>    
>>> @@ -1029,6 +1075,7 @@ static void __dw_mipi_dsi_remove(struct dw_mipi_dsi *dsi)
>>>    	mipi_dsi_host_unregister(&dsi->dsi_host);
>>>    
>>>    	pm_runtime_disable(dsi->dev);
>>> +	dw_mipi_dsi_debugfs_remove(dsi);
>>>    }
>>>    
>>>    void dw_mipi_dsi_set_slave(struct dw_mipi_dsi *dsi, struct dw_mipi_dsi *slave)
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>


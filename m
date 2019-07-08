Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21869C606A1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F2A2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfGHJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfGHJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr1-0004ow-JZ; Mon, 08 Jul 2019 11:22:36 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673794.14831.13178949602156587608.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

up to:  3a1d24ca9573: irq/irqdomain: Fix comment typo

The irq departement provides the usual mixed bag:

  Core:

   - Further improvements to the irq timings code which aims to predict the
     next interrupt for power state selection to achieve better
     latency/power balance

   - Add interrupt statistics to the core NMI handlers

   - The usual small fixes and cleanups

  Drivers:

   - Support for Renesas RZ/A1, Annapurna Labs FIC, Meson-G12A SoC and
     Amazon Gravition AMR/GIC interrupt controllers.

   - Rework of the Renesas INTC controller driver

   - ACPI support for Socionext SoCs

   - Enhancements to the CSKY interrupt controller

   - The usual small fixes and cleanups

Thanks,

	tglx

------------------>
Ard Biesheuvel (4):
      acpi/irq: Implement helper to create hierachical domains
      irqchip/exiu: Preparatory refactor for ACPI support
      irqchip/exiu: Implement ACPI support
      gpio: mb86s7x: Enable ACPI support

Daniel Lezcano (8):
      genirq/timings: Fix next event index function
      genirq/timings: Fix timings buffer inspection
      genirq/timings: Optimize the period detection speed
      genirq/timings: Encapsulate timings push
      genirq/timings: Encapsulate storing function
      genirq/timings: Add selftest for circular array
      genirq/timings: Add selftest for irqs circular buffer
      genirq/timings: Add selftest for next event computation

Geert Uytterhoeven (11):
      genirq/irqdomain: Remove WARN_ON() on out-of-memory condition
      dt-bindings: interrupt-controller: Add Renesas RZ/A1 Interrupt Controller
      irqchip: Add Renesas RZ/A1 Interrupt Controller driver
      irqchip/renesas-irqc: Remove unneeded inclusion of <linux/spinlock.h>
      irqchip/renesas-irqc: Remove error messages on out-of-memory conditions
      irqchip/renesas-irqc: Add helper variable dev = &pdev->dev
      irqchip/renesas-irqc: Replace irqc_priv.pdev by irqc_priv.dev
      irqchip/renesas-irqc: Convert to managed initializations
      irqchip: Enable compile-testing for Renesas drivers
      irqchip/renesas-intc-irqpin: Use proper irq_chip name and parent
      irqchip/renesas-irqc: Use proper irq_chip name and parent

Guo Ren (3):
      irqchip/irq-csky-mpintc: Add triger type
      dt-bindings: interrupt-controller: Update csky mpintc
      irqchip/irq-csky-mpintc: Remove unnecessary loop in interrupt handler

Gustavo A. R. Silva (1):
      irqchip/qcom: Use struct_size() in devm_kzalloc()

Jiangfeng Xiao (1):
      irqchip/gic: Add dependency for ARM_GIC_MAX_NR

Kefeng Wang (1):
      irqchip/mbigen: Stop printing kernel addresses

Minwoo Im (1):
      genirq/affinity: Remove unused argument from [__]irq_build_affinity_masks()

Muchun Song (1):
      softirq: Use __this_cpu_write() in takeover_tasklets()

Sameer Pujar (1):
      irqchip/gic-pm: Remove PM_CLK dependency

Shijith Thotton (1):
      genirq: Update irq stats from NMI handlers

Talel Shenhar (2):
      dt-bindings: interrupt-controller: Add Amazon's Annapurna Labs FIC
      irqchip/al-fic: Introduce Amazon's Annapurna Labs Fabric Interrupt Controller Driver

Xingyu Chen (2):
      dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
      irqchip/meson-gpio: Add support for Meson-G12A SoC

Zeev Zilberman (1):
      irqchip/gic-v2m: Add support for Amazon Graviton variant of GICv3+GICv2m

Zenghui Yu (1):
      irq/irqdomain: Fix comment typo


 .../interrupt-controller/amazon,al-fic.txt         |  29 ++
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../bindings/interrupt-controller/csky,mpintc.txt  |  20 +-
 .../interrupt-controller/renesas,rza1-irqc.txt     |  43 ++
 MAINTAINERS                                        |   6 +
 drivers/acpi/irq.c                                 |  26 ++
 drivers/gpio/gpio-mb86s7x.c                        |  51 ++-
 drivers/irqchip/Kconfig                            |  32 +-
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-al-fic.c                       | 278 +++++++++++++
 drivers/irqchip/irq-csky-mpintc.c                  |  86 +++-
 drivers/irqchip/irq-gic-v2m.c                      |  85 +++-
 drivers/irqchip/irq-gic-v3.c                       |   3 +
 drivers/irqchip/irq-mbigen.c                       |   3 +-
 drivers/irqchip/irq-meson-gpio.c                   |   1 +
 drivers/irqchip/irq-renesas-intc-irqpin.c          |   3 +-
 drivers/irqchip/irq-renesas-irqc.c                 |  91 ++---
 drivers/irqchip/irq-renesas-rza1.c                 | 283 +++++++++++++
 drivers/irqchip/irq-sni-exiu.c                     | 142 +++++--
 drivers/irqchip/qcom-irq-combiner.c                |   5 +-
 include/linux/acpi.h                               |   7 +
 include/linux/irqchip/arm-gic-common.h             |   5 +
 include/linux/irqchip/arm-gic.h                    |   3 -
 kernel/irq/Makefile                                |   3 +
 kernel/irq/affinity.c                              |  12 +-
 kernel/irq/chip.c                                  |   4 +
 kernel/irq/internals.h                             |  21 +-
 kernel/irq/irqdesc.c                               |   8 +-
 kernel/irq/irqdomain.c                             |   4 +-
 kernel/irq/timings.c                               | 453 +++++++++++++++++++--
 kernel/softirq.c                                   |   2 +-
 lib/Kconfig.debug                                  |   8 +
 32 files changed, 1528 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
 create mode 100644 drivers/irqchip/irq-al-fic.c
 create mode 100644 drivers/irqchip/irq-renesas-rza1.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
new file mode 100644
index 000000000000..4e82fd575cec
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
@@ -0,0 +1,29 @@
+Amazon's Annapurna Labs Fabric Interrupt Controller
+
+Required properties:
+
+- compatible: should be "amazon,al-fic"
+- reg: physical base address and size of the registers
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: must be 2.
+  First cell defines the index of the interrupt within the controller.
+  Second cell is used to specify the trigger type and must be one of the
+  following:
+    - bits[3:0] trigger type and level flags
+	1 = low-to-high edge triggered
+	4 = active high level-sensitive
+- interrupt-parent: specifies the parent interrupt controller.
+- interrupts: describes which input line in the interrupt parent, this
+  fic's output is connected to. This field property depends on the parent's
+  binding
+
+Example:
+
+amazon_fic: interrupt-controller@0xfd8a8500 {
+	compatible = "amazon,al-fic";
+	interrupt-controller;
+	#interrupt-cells = <2>;
+	reg = <0x0 0xfd8a8500 0x0 0x1000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SPI 0x0 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 1502a51548bb..7d531d5fff29 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -15,6 +15,7 @@ Required properties:
     "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
+    "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
index ab921f1698fb..e13405355166 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -6,11 +6,16 @@ C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
 SMP soc, and it also could be used in non-SMP system.
 
 Interrupt number definition:
-
   0-15  : software irq, and we use 15 as our IPI_IRQ.
  16-31  : private  irq, and we use 16 as the co-processor timer.
  31-1024: common irq for soc ip.
 
+Interrupt triger mode: (Defined in dt-bindings/interrupt-controller/irq.h)
+ IRQ_TYPE_LEVEL_HIGH (default)
+ IRQ_TYPE_LEVEL_LOW
+ IRQ_TYPE_EDGE_RISING
+ IRQ_TYPE_EDGE_FALLING
+
 =============================
 intc node bindings definition
 =============================
@@ -26,15 +31,22 @@ intc node bindings definition
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-		Definition: must be <1>
+		Definition: <2>
 	- interrupt-controller:
 		Usage: required
 
-Examples:
+Examples: ("interrupts = <irq_num IRQ_TYPE_XXX>")
 ---------
+#include <dt-bindings/interrupt-controller/irq.h>
 
 	intc: interrupt-controller {
 		compatible = "csky,mpintc";
-		#interrupt-cells = <1>;
+		#interrupt-cells = <2>;
 		interrupt-controller;
 	};
+
+	device: device-example {
+		...
+		interrupts = <34 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&intc>;
+	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
new file mode 100644
index 000000000000..727b7e4cd6e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
@@ -0,0 +1,43 @@
+DT bindings for the Renesas RZ/A1 Interrupt Controller
+
+The RZ/A1 Interrupt Controller is a front-end for the GIC found on Renesas
+RZ/A1 and RZ/A2 SoCs:
+  - IRQ sense select for 8 external interrupts, 1:1-mapped to 8 GIC SPI
+    interrupts,
+  - NMI edge select.
+
+Required properties:
+  - compatible: Must be "renesas,<soctype>-irqc", and "renesas,rza1-irqc" as
+		fallback.
+		Examples with soctypes are:
+		  - "renesas,r7s72100-irqc" (RZ/A1H)
+		  - "renesas,r7s9210-irqc" (RZ/A2M)
+  - #interrupt-cells: Must be 2 (an interrupt index and flags, as defined
+				 in interrupts.txt in this directory)
+  - #address-cells: Must be zero
+  - interrupt-controller: Marks the device as an interrupt controller
+  - reg: Base address and length of the memory resource used by the interrupt
+         controller
+  - interrupt-map: Specifies the mapping from external interrupts to GIC
+		   interrupts
+  - interrupt-map-mask: Must be <7 0>
+
+Example:
+
+	irqc: interrupt-controller@fcfef800 {
+		compatible = "renesas,r7s72100-irqc", "renesas,rza1-irqc";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xfcfef800 0x6>;
+		interrupt-map =
+			<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <7 0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 429c6c624861..f1fbe671abc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1304,6 +1304,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 F:	drivers/irqchip/irq-vic.c
 
+AMAZON ANNAPURNA LABS FIC DRIVER
+M:	Talel Shenhar <talel@amazon.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
+F:	drivers/irqchip/irq-al-fic.c
+
 ARM SMMU DRIVERS
 M:	Will Deacon <will.deacon@arm.com>
 R:	Robin Murphy <robin.murphy@arm.com>
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c3b2222e2129..ce6b25a3b7a7 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -295,3 +295,29 @@ void __init acpi_set_irq_model(enum acpi_irq_model_id model,
 	acpi_irq_model = model;
 	acpi_gsi_domain_id = fwnode;
 }
+
+/**
+ * acpi_irq_create_hierarchy - Create a hierarchical IRQ domain with the default
+ *                             GSI domain as its parent.
+ * @flags:      Irq domain flags associated with the domain
+ * @size:       Size of the domain.
+ * @fwnode:     Optional fwnode of the interrupt controller
+ * @ops:        Pointer to the interrupt domain callbacks
+ * @host_data:  Controller private data pointer
+ */
+struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
+					     unsigned int size,
+					     struct fwnode_handle *fwnode,
+					     const struct irq_domain_ops *ops,
+					     void *host_data)
+{
+	struct irq_domain *d = irq_find_matching_fwnode(acpi_gsi_domain_id,
+							DOMAIN_BUS_ANY);
+
+	if (!d)
+		return NULL;
+
+	return irq_domain_create_hierarchy(d, flags, size, fwnode, ops,
+					   host_data);
+}
+EXPORT_SYMBOL_GPL(acpi_irq_create_hierarchy);
diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 9308081e0a4a..64027f57a8aa 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -14,6 +14,7 @@
  *  GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/clk.h>
@@ -27,6 +28,8 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
+#include "gpiolib.h"
+
 /*
  * Only first 8bits of a register correspond to each pin,
  * so there are 4 registers for 32 pins.
@@ -143,6 +146,20 @@ static void mb86s70_gpio_set(struct gpio_chip *gc, unsigned gpio, int value)
 	spin_unlock_irqrestore(&gchip->lock, flags);
 }
 
+static int mb86s70_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	int irq, index;
+
+	for (index = 0;; index++) {
+		irq = platform_get_irq(to_platform_device(gc->parent), index);
+		if (irq <= 0)
+			break;
+		if (irq_get_irq_data(irq)->hwirq == offset)
+			return irq;
+	}
+	return -EINVAL;
+}
+
 static int mb86s70_gpio_probe(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip;
@@ -158,13 +175,15 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gchip->base))
 		return PTR_ERR(gchip->base);
 
-	gchip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(gchip->clk))
-		return PTR_ERR(gchip->clk);
+	if (!has_acpi_companion(&pdev->dev)) {
+		gchip->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(gchip->clk))
+			return PTR_ERR(gchip->clk);
 
-	ret = clk_prepare_enable(gchip->clk);
-	if (ret)
-		return ret;
+		ret = clk_prepare_enable(gchip->clk);
+		if (ret)
+			return ret;
+	}
 
 	spin_lock_init(&gchip->lock);
 
@@ -180,19 +199,28 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	gchip->gc.parent = &pdev->dev;
 	gchip->gc.base = -1;
 
+	if (has_acpi_companion(&pdev->dev))
+		gchip->gc.to_irq = mb86s70_gpio_to_irq;
+
 	ret = gpiochip_add_data(&gchip->gc, gchip);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register gpio driver\n");
 		clk_disable_unprepare(gchip->clk);
+		return ret;
 	}
 
-	return ret;
+	if (has_acpi_companion(&pdev->dev))
+		acpi_gpiochip_request_interrupts(&gchip->gc);
+
+	return 0;
 }
 
 static int mb86s70_gpio_remove(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip = platform_get_drvdata(pdev);
 
+	if (has_acpi_companion(&pdev->dev))
+		acpi_gpiochip_free_interrupts(&gchip->gc);
 	gpiochip_remove(&gchip->gc);
 	clk_disable_unprepare(gchip->clk);
 
@@ -205,10 +233,19 @@ static const struct of_device_id mb86s70_gpio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mb86s70_gpio_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mb86s70_gpio_acpi_ids[] = {
+	{ "SCX0007" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, mb86s70_gpio_acpi_ids);
+#endif
+
 static struct platform_driver mb86s70_gpio_driver = {
 	.driver = {
 		.name = "mb86s70-gpio",
 		.of_match_table = mb86s70_gpio_dt_ids,
+		.acpi_match_table = ACPI_PTR(mb86s70_gpio_acpi_ids),
 	},
 	.probe = mb86s70_gpio_probe,
 	.remove = mb86s70_gpio_remove,
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 659c5e0fb835..80e10f4e213a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -15,10 +15,10 @@ config ARM_GIC_PM
 	bool
 	depends on PM
 	select ARM_GIC
-	select PM_CLK
 
 config ARM_GIC_MAX_NR
 	int
+	depends on ARM_GIC
 	default 2 if ARCH_REALVIEW
 	default 1
 
@@ -87,6 +87,14 @@ config ALPINE_MSI
 	select PCI_MSI
 	select GENERIC_IRQ_CHIP
 
+config AL_FIC
+	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
+	depends on OF || COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	help
+	  Support Amazon's Annapurna Labs Fabric Interrupt Controller.
+
 config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
@@ -217,13 +225,26 @@ config RDA_INTC
 	select IRQ_DOMAIN
 
 config RENESAS_INTC_IRQPIN
-	bool
+	bool "Renesas INTC External IRQ Pin Support" if COMPILE_TEST
 	select IRQ_DOMAIN
+	help
+	  Enable support for the Renesas Interrupt Controller for external
+	  interrupt pins, as found on SH/R-Mobile and R-Car Gen1 SoCs.
 
 config RENESAS_IRQC
-	bool
+	bool "Renesas R-Mobile APE6 and R-Car IRQC support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
+	help
+	  Enable support for the Renesas Interrupt Controller for external
+	  devices, as found on R-Mobile APE6, R-Car Gen2, and R-Car Gen3 SoCs.
+
+config RENESAS_RZA1_IRQC
+	bool "Renesas RZ/A1 IRQC support" if COMPILE_TEST
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
+	  to 8 external interrupts with configurable sense select.
 
 config ST_IRQCHIP
 	bool
@@ -299,8 +320,11 @@ config RENESAS_H8300H_INTC
 	select IRQ_DOMAIN
 
 config RENESAS_H8S_INTC
-        bool
+	bool "Renesas H8S Interrupt Controller Support" if COMPILE_TEST
 	select IRQ_DOMAIN
+	help
+	  Enable support for the Renesas H8/300 Interrupt Controller, as found
+	  on Renesas H8S SoCs.
 
 config IMX_GPCV2
 	bool
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 606a003a0000..8d0fcec6ab23 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
+obj-$(CONFIG_AL_FIC)			+= irq-al-fic.o
 obj-$(CONFIG_ALPINE_MSI)		+= irq-alpine-msi.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
@@ -49,6 +50,7 @@ obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
 obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
+obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
new file mode 100644
index 000000000000..1a57cee3efab
--- /dev/null
+++ b/drivers/irqchip/irq-al-fic.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+/* FIC Registers */
+#define AL_FIC_CAUSE		0x00
+#define AL_FIC_MASK		0x10
+#define AL_FIC_CONTROL		0x28
+
+#define CONTROL_TRIGGER_RISING	BIT(3)
+#define CONTROL_MASK_MSI_X	BIT(5)
+
+#define NR_FIC_IRQS 32
+
+MODULE_AUTHOR("Talel Shenhar");
+MODULE_DESCRIPTION("Amazon's Annapurna Labs Interrupt Controller Driver");
+MODULE_LICENSE("GPL v2");
+
+enum al_fic_state {
+	AL_FIC_UNCONFIGURED = 0,
+	AL_FIC_CONFIGURED_LEVEL,
+	AL_FIC_CONFIGURED_RISING_EDGE,
+};
+
+struct al_fic {
+	void __iomem *base;
+	struct irq_domain *domain;
+	const char *name;
+	unsigned int parent_irq;
+	enum al_fic_state state;
+};
+
+static void al_fic_set_trigger(struct al_fic *fic,
+			       struct irq_chip_generic *gc,
+			       enum al_fic_state new_state)
+{
+	irq_flow_handler_t handler;
+	u32 control = readl_relaxed(fic->base + AL_FIC_CONTROL);
+
+	if (new_state == AL_FIC_CONFIGURED_LEVEL) {
+		handler = handle_level_irq;
+		control &= ~CONTROL_TRIGGER_RISING;
+	} else {
+		handler = handle_edge_irq;
+		control |= CONTROL_TRIGGER_RISING;
+	}
+	gc->chip_types->handler = handler;
+	fic->state = new_state;
+	writel_relaxed(control, fic->base + AL_FIC_CONTROL);
+}
+
+static int al_fic_irq_set_type(struct irq_data *data, unsigned int flow_type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct al_fic *fic = gc->private;
+	enum al_fic_state new_state;
+	int ret = 0;
+
+	irq_gc_lock(gc);
+
+	if (((flow_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_HIGH) &&
+	    ((flow_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_EDGE_RISING)) {
+		pr_debug("fic doesn't support flow type %d\n", flow_type);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	new_state = (flow_type & IRQ_TYPE_LEVEL_HIGH) ?
+		AL_FIC_CONFIGURED_LEVEL : AL_FIC_CONFIGURED_RISING_EDGE;
+
+	/*
+	 * A given FIC instance can be either all level or all edge triggered.
+	 * This is generally fixed depending on what pieces of HW it's wired up
+	 * to.
+	 *
+	 * We configure it based on the sensitivity of the first source
+	 * being setup, and reject any subsequent attempt at configuring it in a
+	 * different way.
+	 */
+	if (fic->state == AL_FIC_UNCONFIGURED) {
+		al_fic_set_trigger(fic, gc, new_state);
+	} else if (fic->state != new_state) {
+		pr_debug("fic %s state already configured to %d\n",
+			 fic->name, fic->state);
+		ret = -EINVAL;
+		goto err;
+	}
+
+err:
+	irq_gc_unlock(gc);
+
+	return ret;
+}
+
+static void al_fic_irq_handler(struct irq_desc *desc)
+{
+	struct al_fic *fic = irq_desc_get_handler_data(desc);
+	struct irq_domain *domain = fic->domain;
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(domain, 0);
+	unsigned long pending;
+	unsigned int irq;
+	u32 hwirq;
+
+	chained_irq_enter(irqchip, desc);
+
+	pending = readl_relaxed(fic->base + AL_FIC_CAUSE);
+	pending &= ~gc->mask_cache;
+
+	for_each_set_bit(hwirq, &pending, NR_FIC_IRQS) {
+		irq = irq_find_mapping(domain, hwirq);
+		generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static int al_fic_register(struct device_node *node,
+			   struct al_fic *fic)
+{
+	struct irq_chip_generic *gc;
+	int ret;
+
+	fic->domain = irq_domain_add_linear(node,
+					    NR_FIC_IRQS,
+					    &irq_generic_chip_ops,
+					    fic);
+	if (!fic->domain) {
+		pr_err("fail to add irq domain\n");
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(fic->domain,
+					     NR_FIC_IRQS,
+					     1, fic->name,
+					     handle_level_irq,
+					     0, 0, IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		pr_err("fail to allocate generic chip (%d)\n", ret);
+		goto err_domain_remove;
+	}
+
+	gc = irq_get_domain_generic_chip(fic->domain, 0);
+	gc->reg_base = fic->base;
+	gc->chip_types->regs.mask = AL_FIC_MASK;
+	gc->chip_types->regs.ack = AL_FIC_CAUSE;
+	gc->chip_types->chip.irq_mask = irq_gc_mask_set_bit;
+	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
+	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
+	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
+	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
+	gc->private = fic;
+
+	irq_set_chained_handler_and_data(fic->parent_irq,
+					 al_fic_irq_handler,
+					 fic);
+	return 0;
+
+err_domain_remove:
+	irq_domain_remove(fic->domain);
+
+	return ret;
+}
+
+/*
+ * al_fic_wire_init() - initialize and configure fic in wire mode
+ * @of_node: optional pointer to interrupt controller's device tree node.
+ * @base: mmio to fic register
+ * @name: name of the fic
+ * @parent_irq: interrupt of parent
+ *
+ * This API will configure the fic hardware to to work in wire mode.
+ * In wire mode, fic hardware is generating a wire ("wired") interrupt.
+ * Interrupt can be generated based on positive edge or level - configuration is
+ * to be determined based on connected hardware to this fic.
+ */
+static struct al_fic *al_fic_wire_init(struct device_node *node,
+				       void __iomem *base,
+				       const char *name,
+				       unsigned int parent_irq)
+{
+	struct al_fic *fic;
+	int ret;
+	u32 control = CONTROL_MASK_MSI_X;
+
+	fic = kzalloc(sizeof(*fic), GFP_KERNEL);
+	if (!fic)
+		return ERR_PTR(-ENOMEM);
+
+	fic->base = base;
+	fic->parent_irq = parent_irq;
+	fic->name = name;
+
+	/* mask out all interrupts */
+	writel_relaxed(0xFFFFFFFF, fic->base + AL_FIC_MASK);
+
+	/* clear any pending interrupt */
+	writel_relaxed(0, fic->base + AL_FIC_CAUSE);
+
+	writel_relaxed(control, fic->base + AL_FIC_CONTROL);
+
+	ret = al_fic_register(node, fic);
+	if (ret) {
+		pr_err("fail to register irqchip\n");
+		goto err_free;
+	}
+
+	pr_debug("%s initialized successfully in Legacy mode (parent-irq=%u)\n",
+		 fic->name, parent_irq);
+
+	return fic;
+
+err_free:
+	kfree(fic);
+	return ERR_PTR(ret);
+}
+
+static int __init al_fic_init_dt(struct device_node *node,
+				 struct device_node *parent)
+{
+	int ret;
+	void __iomem *base;
+	unsigned int parent_irq;
+	struct al_fic *fic;
+
+	if (!parent) {
+		pr_err("%s: unsupported - device require a parent\n",
+		       node->name);
+		return -EINVAL;
+	}
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: fail to map memory\n", node->name);
+		return -ENOMEM;
+	}
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		pr_err("%s: fail to map irq\n", node->name);
+		ret = -EINVAL;
+		goto err_unmap;
+	}
+
+	fic = al_fic_wire_init(node,
+			       base,
+			       node->name,
+			       parent_irq);
+	if (IS_ERR(fic)) {
+		pr_err("%s: fail to initialize irqchip (%lu)\n",
+		       node->name,
+		       PTR_ERR(fic));
+		ret = PTR_ERR(fic);
+		goto err_irq_dispose;
+	}
+
+	return 0;
+
+err_irq_dispose:
+	irq_dispose_mapping(parent_irq);
+err_unmap:
+	iounmap(base);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(al_fic, "amazon,al-fic", al_fic_init_dt);
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961ab6cc..806ba0ef33c0 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -32,8 +32,8 @@ static void __iomem *INTCL_base;
 #define INTCG_CIDSTR	0x1000
 
 #define INTCL_PICTLR	0x0
+#define INTCL_CFGR	0x14
 #define INTCL_SIGR	0x60
-#define INTCL_HPPIR	0x68
 #define INTCL_RDYIR	0x6c
 #define INTCL_SENR	0xa0
 #define INTCL_CENR	0xa4
@@ -41,21 +41,49 @@ static void __iomem *INTCL_base;
 
 static DEFINE_PER_CPU(void __iomem *, intcl_reg);
 
+static unsigned long *__trigger;
+
+#define IRQ_OFFSET(irq) ((irq < COMM_IRQ_BASE) ? irq : (irq - COMM_IRQ_BASE))
+
+#define TRIG_BYTE_OFFSET(i)	((((i) * 2) / 32) * 4)
+#define TRIG_BIT_OFFSET(i)	 (((i) * 2) % 32)
+
+#define TRIG_VAL(trigger, irq)	(trigger << TRIG_BIT_OFFSET(IRQ_OFFSET(irq)))
+#define TRIG_VAL_MSK(irq)	    (~(3 << TRIG_BIT_OFFSET(IRQ_OFFSET(irq))))
+
+#define TRIG_BASE(irq) \
+	(TRIG_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
+	(this_cpu_read(intcl_reg) + INTCL_CFGR) : (INTCG_base + INTCG_CICFGR)))
+
+static DEFINE_SPINLOCK(setup_lock);
+static void setup_trigger(unsigned long irq, unsigned long trigger)
+{
+	unsigned int tmp;
+
+	spin_lock(&setup_lock);
+
+	/* setup trigger */
+	tmp = readl_relaxed(TRIG_BASE(irq)) & TRIG_VAL_MSK(irq);
+
+	writel_relaxed(tmp | TRIG_VAL(trigger, irq), TRIG_BASE(irq));
+
+	spin_unlock(&setup_lock);
+}
+
 static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
-	do {
-		handle_domain_irq(root_domain,
-				  readl_relaxed(reg_base + INTCL_RDYIR),
-				  regs);
-	} while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
+	handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR), regs);
 }
 
 static void csky_mpintc_enable(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
+	setup_trigger(d->hwirq, __trigger[d->hwirq]);
+
 	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
 }
 
@@ -73,6 +101,28 @@ static void csky_mpintc_eoi(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
 }
 
+static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
+{
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		__trigger[d->hwirq] = 0;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		__trigger[d->hwirq] = 1;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		__trigger[d->hwirq] = 2;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		__trigger[d->hwirq] = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int csky_irq_set_affinity(struct irq_data *d,
 				 const struct cpumask *mask_val,
@@ -105,6 +155,7 @@ static struct irq_chip csky_irq_chip = {
 	.irq_eoi	= csky_mpintc_eoi,
 	.irq_enable	= csky_mpintc_enable,
 	.irq_disable	= csky_mpintc_disable,
+	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
 #endif
@@ -125,9 +176,26 @@ static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int csky_irq_domain_xlate_cells(struct irq_domain *d,
+		struct device_node *ctrlr, const u32 *intspec,
+		unsigned int intsize, unsigned long *out_hwirq,
+		unsigned int *out_type)
+{
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1)
+		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	else
+		*out_type = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
 static const struct irq_domain_ops csky_irqdomain_ops = {
 	.map	= csky_irqdomain_map,
-	.xlate	= irq_domain_xlate_onecell,
+	.xlate	= csky_irq_domain_xlate_cells,
 };
 
 #ifdef CONFIG_SMP
@@ -161,6 +229,10 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 	if (ret < 0)
 		nr_irq = INTC_IRQS;
 
+	__trigger  = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
+	if (__trigger == NULL)
+		return -ENXIO;
+
 	if (INTCG_base == NULL) {
 		INTCG_base = ioremap(mfcr("cr<31, 14>"),
 				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 3c77ab676e54..5356739d4799 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -56,6 +56,7 @@
 
 /* List of flags for specific v2m implementation */
 #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
+#define GICV2M_GRAVITON_ADDRESS_ONLY	0x00000002
 
 static LIST_HEAD(v2m_nodes);
 static DEFINE_SPINLOCK(v2m_lock);
@@ -98,15 +99,26 @@ static struct msi_domain_info gicv2m_msi_domain_info = {
 	.chip	= &gicv2m_msi_irq_chip,
 };
 
+static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
+{
+	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
+		return v2m->res.start | ((hwirq - 32) << 3);
+	else
+		return v2m->res.start + V2M_MSI_SETSPI_NS;
+}
+
 static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
+	phys_addr_t addr = gicv2m_get_msi_addr(v2m, data->hwirq);
 
 	msg->address_hi = upper_32_bits(addr);
 	msg->address_lo = lower_32_bits(addr);
-	msg->data = data->hwirq;
 
+	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
+		msg->data = 0;
+	else
+		msg->data = data->hwirq;
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
 		msg->data -= v2m->spi_offset;
 
@@ -188,7 +200,7 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	hwirq = v2m->spi_start + offset;
 
 	err = iommu_dma_prepare_msi(info->desc,
-				    v2m->res.start + V2M_MSI_SETSPI_NS);
+				    gicv2m_get_msi_addr(v2m, hwirq));
 	if (err)
 		return err;
 
@@ -307,7 +319,7 @@ static int gicv2m_allocate_domains(struct irq_domain *parent)
 
 static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 				  u32 spi_start, u32 nr_spis,
-				  struct resource *res)
+				  struct resource *res, u32 flags)
 {
 	int ret;
 	struct v2m_data *v2m;
@@ -320,6 +332,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 
 	INIT_LIST_HEAD(&v2m->entry);
 	v2m->fwnode = fwnode;
+	v2m->flags = flags;
 
 	memcpy(&v2m->res, res, sizeof(struct resource));
 
@@ -334,7 +347,14 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 		v2m->spi_start = spi_start;
 		v2m->nr_spis = nr_spis;
 	} else {
-		u32 typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
+		u32 typer;
+
+		/* Graviton should always have explicit spi_start/nr_spis */
+		if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY) {
+			ret = -EINVAL;
+			goto err_iounmap;
+		}
+		typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
 
 		v2m->spi_start = V2M_MSI_TYPER_BASE_SPI(typer);
 		v2m->nr_spis = V2M_MSI_TYPER_NUM_SPI(typer);
@@ -355,18 +375,21 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	 *
 	 * Broadom NS2 GICv2m implementation has an erratum where the MSI data
 	 * is 'spi_number - 32'
+	 *
+	 * Reading that register fails on the Graviton implementation
 	 */
-	switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
-	case XGENE_GICV2M_MSI_IIDR:
-		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
-		v2m->spi_offset = v2m->spi_start;
-		break;
-	case BCM_NS2_GICV2M_MSI_IIDR:
-		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
-		v2m->spi_offset = 32;
-		break;
+	if (!(v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)) {
+		switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
+		case XGENE_GICV2M_MSI_IIDR:
+			v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+			v2m->spi_offset = v2m->spi_start;
+			break;
+		case BCM_NS2_GICV2M_MSI_IIDR:
+			v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+			v2m->spi_offset = 32;
+			break;
+		}
 	}
-
 	v2m->bm = kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
 			  GFP_KERNEL);
 	if (!v2m->bm) {
@@ -419,7 +442,8 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 			pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
 				spi_start, nr_spis);
 
-		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis, &res);
+		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
+				      &res, 0);
 		if (ret) {
 			of_node_put(child);
 			break;
@@ -451,6 +475,25 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 	return data->fwnode;
 }
 
+static bool acpi_check_amazon_graviton_quirks(void)
+{
+	static struct acpi_table_madt *madt;
+	acpi_status status;
+	bool rc = false;
+
+#define ACPI_AMZN_OEM_ID		"AMAZON"
+
+	status = acpi_get_table(ACPI_SIG_MADT, 0,
+				(struct acpi_table_header **)&madt);
+
+	if (ACPI_FAILURE(status) || !madt)
+		return rc;
+	rc = !memcmp(madt->header.oem_id, ACPI_AMZN_OEM_ID, ACPI_OEM_ID_SIZE);
+	acpi_put_table((struct acpi_table_header *)madt);
+
+	return rc;
+}
+
 static int __init
 acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		    const unsigned long end)
@@ -460,6 +503,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 	u32 spi_start = 0, nr_spis = 0;
 	struct acpi_madt_generic_msi_frame *m;
 	struct fwnode_handle *fwnode;
+	u32 flags = 0;
 
 	m = (struct acpi_madt_generic_msi_frame *)header;
 	if (BAD_MADT_ENTRY(m, end))
@@ -469,6 +513,13 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 	res.end = m->base_address + SZ_4K - 1;
 	res.flags = IORESOURCE_MEM;
 
+	if (acpi_check_amazon_graviton_quirks()) {
+		pr_info("applying Amazon Graviton quirk\n");
+		res.end = res.start + SZ_8K - 1;
+		flags |= GICV2M_GRAVITON_ADDRESS_ONLY;
+		gicv2m_msi_domain_info.flags &= ~MSI_FLAG_MULTI_PCI_MSI;
+	}
+
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
 		spi_start = m->spi_base;
 		nr_spis = m->spi_count;
@@ -483,7 +534,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
+	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res, flags);
 	if (ret)
 		irq_domain_free_fwnode(fwnode);
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f44cd89cfc40..1282f81696b2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1343,6 +1343,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 		its_cpu_init();
+	} else {
+		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+			gicv2m_init(handle, gic_data.domain);
 	}
 
 	if (gic_prio_masking_enabled()) {
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 98b6e1d4b1a6..c0f65ea0ae0f 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -355,8 +355,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
 		err = -EINVAL;
 
 	if (err) {
-		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain",
-			mgn_chip->base);
+		dev_err(&pdev->dev, "Failed to create mbi-gen irqdomain\n");
 		return err;
 	}
 
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b531fd075b8..7599b10ecf09 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -73,6 +73,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
+	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ }
 };
 
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 04c05a18600c..f82bc60a6793 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -508,7 +508,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	irq_chip = &p->irq_chip;
-	irq_chip->name = name;
+	irq_chip->name = "intc-irqpin";
+	irq_chip->parent_device = dev;
 	irq_chip->irq_mask = disable_fn;
 	irq_chip->irq_unmask = enable_fn;
 	irq_chip->irq_set_type = intc_irqpin_irq_set_type;
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index a449a7c839b3..11abc09ef76c 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -7,7 +7,6 @@
 
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -48,7 +47,7 @@ struct irqc_priv {
 	void __iomem *cpu_int_base;
 	struct irqc_irq irq[IRQC_IRQ_MAX];
 	unsigned int number_of_irqs;
-	struct platform_device *pdev;
+	struct device *dev;
 	struct irq_chip_generic *gc;
 	struct irq_domain *irq_domain;
 	atomic_t wakeup_path;
@@ -61,8 +60,7 @@ static struct irqc_priv *irq_data_to_priv(struct irq_data *data)
 
 static void irqc_dbg(struct irqc_irq *i, char *str)
 {
-	dev_dbg(&i->p->pdev->dev, "%s (%d:%d)\n",
-		str, i->requested_irq, i->hw_irq);
+	dev_dbg(i->p->dev, "%s (%d:%d)\n", str, i->requested_irq, i->hw_irq);
 }
 
 static unsigned char irqc_sense[IRQ_TYPE_SENSE_MASK + 1] = {
@@ -125,33 +123,22 @@ static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 
 static int irqc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	const char *name = dev_name(dev);
 	struct irqc_priv *p;
-	struct resource *io;
 	struct resource *irq;
-	const char *name = dev_name(&pdev->dev);
 	int ret;
 	int k;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p) {
-		dev_err(&pdev->dev, "failed to allocate driver data\n");
-		ret = -ENOMEM;
-		goto err0;
-	}
+	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
 
-	p->pdev = pdev;
+	p->dev = dev;
 	platform_set_drvdata(pdev, p);
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
-	/* get hold of manadatory IOMEM */
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!io) {
-		dev_err(&pdev->dev, "not enough IOMEM resources\n");
-		ret = -EINVAL;
-		goto err1;
-	}
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	/* allow any number of IRQs between 1 and IRQC_IRQ_MAX */
 	for (k = 0; k < IRQC_IRQ_MAX; k++) {
@@ -166,42 +153,41 @@ static int irqc_probe(struct platform_device *pdev)
 
 	p->number_of_irqs = k;
 	if (p->number_of_irqs < 1) {
-		dev_err(&pdev->dev, "not enough IRQ resources\n");
+		dev_err(dev, "not enough IRQ resources\n");
 		ret = -EINVAL;
-		goto err1;
+		goto err_runtime_pm_disable;
 	}
 
 	/* ioremap IOMEM and setup read/write callbacks */
-	p->iomem = ioremap_nocache(io->start, resource_size(io));
-	if (!p->iomem) {
-		dev_err(&pdev->dev, "failed to remap IOMEM\n");
-		ret = -ENXIO;
-		goto err2;
+	p->iomem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(p->iomem)) {
+		ret = PTR_ERR(p->iomem);
+		goto err_runtime_pm_disable;
 	}
 
 	p->cpu_int_base = p->iomem + IRQC_INT_CPU_BASE(0); /* SYS-SPI */
 
-	p->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
-					      p->number_of_irqs,
+	p->irq_domain = irq_domain_add_linear(dev->of_node, p->number_of_irqs,
 					      &irq_generic_chip_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
-		dev_err(&pdev->dev, "cannot initialize irq domain\n");
-		goto err2;
+		dev_err(dev, "cannot initialize irq domain\n");
+		goto err_runtime_pm_disable;
 	}
 
 	ret = irq_alloc_domain_generic_chips(p->irq_domain, p->number_of_irqs,
-					     1, name, handle_level_irq,
+					     1, "irqc", handle_level_irq,
 					     0, 0, IRQ_GC_INIT_NESTED_LOCK);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot allocate generic chip\n");
-		goto err3;
+		dev_err(dev, "cannot allocate generic chip\n");
+		goto err_remove_domain;
 	}
 
 	p->gc = irq_get_domain_generic_chip(p->irq_domain, 0);
 	p->gc->reg_base = p->cpu_int_base;
 	p->gc->chip_types[0].regs.enable = IRQC_EN_SET;
 	p->gc->chip_types[0].regs.disable = IRQC_EN_STS;
+	p->gc->chip_types[0].chip.parent_device = dev;
 	p->gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
 	p->gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
 	p->gc->chip_types[0].chip.irq_set_type	= irqc_irq_set_type;
@@ -210,46 +196,33 @@ static int irqc_probe(struct platform_device *pdev)
 
 	/* request interrupts one by one */
 	for (k = 0; k < p->number_of_irqs; k++) {
-		if (request_irq(p->irq[k].requested_irq, irqc_irq_handler,
-				0, name, &p->irq[k])) {
-			dev_err(&pdev->dev, "failed to request IRQ\n");
+		if (devm_request_irq(dev, p->irq[k].requested_irq,
+				     irqc_irq_handler, 0, name, &p->irq[k])) {
+			dev_err(dev, "failed to request IRQ\n");
 			ret = -ENOENT;
-			goto err4;
+			goto err_remove_domain;
 		}
 	}
 
-	dev_info(&pdev->dev, "driving %d irqs\n", p->number_of_irqs);
+	dev_info(dev, "driving %d irqs\n", p->number_of_irqs);
 
 	return 0;
-err4:
-	while (--k >= 0)
-		free_irq(p->irq[k].requested_irq, &p->irq[k]);
 
-err3:
+err_remove_domain:
 	irq_domain_remove(p->irq_domain);
-err2:
-	iounmap(p->iomem);
-err1:
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	kfree(p);
-err0:
+err_runtime_pm_disable:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
 static int irqc_remove(struct platform_device *pdev)
 {
 	struct irqc_priv *p = platform_get_drvdata(pdev);
-	int k;
-
-	for (k = 0; k < p->number_of_irqs; k++)
-		free_irq(p->irq[k].requested_irq, &p->irq[k]);
 
 	irq_domain_remove(p->irq_domain);
-	iounmap(p->iomem);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	kfree(p);
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
new file mode 100644
index 000000000000..b1f19b210190
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/A1 IRQC Driver
+ *
+ * Copyright (C) 2019 Glider bvba
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define IRQC_NUM_IRQ		8
+
+#define ICR0			0	/* Interrupt Control Register 0 */
+
+#define ICR0_NMIL		BIT(15)	/* NMI Input Level (0=low, 1=high) */
+#define ICR0_NMIE		BIT(8)	/* Edge Select (0=falling, 1=rising) */
+#define ICR0_NMIF		BIT(1)	/* NMI Interrupt Request */
+
+#define ICR1			2	/* Interrupt Control Register 1 */
+
+#define ICR1_IRQS(n, sense)	((sense) << ((n) * 2))	/* IRQ Sense Select */
+#define ICR1_IRQS_LEVEL_LOW	0
+#define ICR1_IRQS_EDGE_FALLING	1
+#define ICR1_IRQS_EDGE_RISING	2
+#define ICR1_IRQS_EDGE_BOTH	3
+#define ICR1_IRQS_MASK(n)	ICR1_IRQS((n), 3)
+
+#define IRQRR			4	/* IRQ Interrupt Request Register */
+
+
+struct rza1_irqc_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct irq_chip chip;
+	struct irq_domain *irq_domain;
+	struct of_phandle_args map[IRQC_NUM_IRQ];
+};
+
+static struct rza1_irqc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void rza1_irqc_eoi(struct irq_data *d)
+{
+	struct rza1_irqc_priv *priv = irq_data_to_priv(d);
+	u16 bit = BIT(irqd_to_hwirq(d));
+	u16 tmp;
+
+	tmp = readw_relaxed(priv->base + IRQRR);
+	if (tmp & bit)
+		writew_relaxed(GENMASK(IRQC_NUM_IRQ - 1, 0) & ~bit,
+			       priv->base + IRQRR);
+
+	irq_chip_eoi_parent(d);
+}
+
+static int rza1_irqc_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rza1_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	u16 sense, tmp;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense = ICR1_IRQS_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = ICR1_IRQS_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense = ICR1_IRQS_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		sense = ICR1_IRQS_EDGE_BOTH;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tmp = readw_relaxed(priv->base + ICR1);
+	tmp &= ~ICR1_IRQS_MASK(hw_irq);
+	tmp |= ICR1_IRQS(hw_irq, sense);
+	writew_relaxed(tmp, priv->base + ICR1);
+	return 0;
+}
+
+static int rza1_irqc_alloc(struct irq_domain *domain, unsigned int virq,
+			   unsigned int nr_irqs, void *arg)
+{
+	struct rza1_irqc_priv *priv = domain->host_data;
+	struct irq_fwspec *fwspec = arg;
+	unsigned int hwirq = fwspec->param[0];
+	struct irq_fwspec spec;
+	unsigned int i;
+	int ret;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &priv->chip,
+					    priv);
+	if (ret)
+		return ret;
+
+	spec.fwnode = &priv->dev->of_node->fwnode;
+	spec.param_count = priv->map[hwirq].args_count;
+	for (i = 0; i < spec.param_count; i++)
+		spec.param[i] = priv->map[hwirq].args[i];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &spec);
+}
+
+static int rza1_irqc_translate(struct irq_domain *domain,
+			       struct irq_fwspec *fwspec, unsigned long *hwirq,
+			       unsigned int *type)
+{
+	if (fwspec->param_count != 2 || fwspec->param[0] >= IRQC_NUM_IRQ)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+	return 0;
+}
+
+static const struct irq_domain_ops rza1_irqc_domain_ops = {
+	.alloc = rza1_irqc_alloc,
+	.translate = rza1_irqc_translate,
+};
+
+static int rza1_irqc_parse_map(struct rza1_irqc_priv *priv,
+			       struct device_node *gic_node)
+{
+	unsigned int imaplen, i, j, ret;
+	struct device *dev = priv->dev;
+	struct device_node *ipar;
+	const __be32 *imap;
+	u32 intsize;
+
+	imap = of_get_property(dev->of_node, "interrupt-map", &imaplen);
+	if (!imap)
+		return -EINVAL;
+
+	for (i = 0; i < IRQC_NUM_IRQ; i++) {
+		if (imaplen < 3)
+			return -EINVAL;
+
+		/* Check interrupt number, ignore sense */
+		if (be32_to_cpup(imap) != i)
+			return -EINVAL;
+
+		ipar = of_find_node_by_phandle(be32_to_cpup(imap + 2));
+		if (ipar != gic_node) {
+			of_node_put(ipar);
+			return -EINVAL;
+		}
+
+		imap += 3;
+		imaplen -= 3;
+
+		ret = of_property_read_u32(ipar, "#interrupt-cells", &intsize);
+		of_node_put(ipar);
+		if (ret)
+			return ret;
+
+		if (imaplen < intsize)
+			return -EINVAL;
+
+		priv->map[i].args_count = intsize;
+		for (j = 0; j < intsize; j++)
+			priv->map[i].args[j] = be32_to_cpup(imap++);
+
+		imaplen -= intsize;
+	}
+
+	return 0;
+}
+
+static int rza1_irqc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct irq_domain *parent = NULL;
+	struct device_node *gic_node;
+	struct rza1_irqc_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	gic_node = of_irq_find_parent(np);
+	if (gic_node) {
+		parent = irq_find_host(gic_node);
+		of_node_put(gic_node);
+	}
+
+	if (!parent) {
+		dev_err(dev, "cannot find parent domain\n");
+		return -ENODEV;
+	}
+
+	ret = rza1_irqc_parse_map(priv, gic_node);
+	if (ret) {
+		dev_err(dev, "cannot parse %s: %d\n", "interrupt-map", ret);
+		return ret;
+	}
+
+	priv->chip.name = "rza1-irqc",
+	priv->chip.irq_mask = irq_chip_mask_parent,
+	priv->chip.irq_unmask = irq_chip_unmask_parent,
+	priv->chip.irq_eoi = rza1_irqc_eoi,
+	priv->chip.irq_retrigger = irq_chip_retrigger_hierarchy,
+	priv->chip.irq_set_type = rza1_irqc_set_type,
+	priv->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
+
+	priv->irq_domain = irq_domain_add_hierarchy(parent, 0, IRQC_NUM_IRQ,
+						    np, &rza1_irqc_domain_ops,
+						    priv);
+	if (!priv->irq_domain) {
+		dev_err(dev, "cannot initialize irq domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int rza1_irqc_remove(struct platform_device *pdev)
+{
+	struct rza1_irqc_priv *priv = platform_get_drvdata(pdev);
+
+	irq_domain_remove(priv->irq_domain);
+	return 0;
+}
+
+static const struct of_device_id rza1_irqc_dt_ids[] = {
+	{ .compatible = "renesas,rza1-irqc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rza1_irqc_dt_ids);
+
+static struct platform_driver rza1_irqc_device_driver = {
+	.probe		= rza1_irqc_probe,
+	.remove		= rza1_irqc_remove,
+	.driver		= {
+		.name	= "renesas_rza1_irqc",
+		.of_match_table	= rza1_irqc_dt_ids,
+	}
+};
+
+static int __init rza1_irqc_init(void)
+{
+	return platform_driver_register(&rza1_irqc_device_driver);
+}
+postcore_initcall(rza1_irqc_init);
+
+static void __exit rza1_irqc_exit(void)
+{
+	platform_driver_unregister(&rza1_irqc_device_driver);
+}
+module_exit(rza1_irqc_exit);
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
+MODULE_DESCRIPTION("Renesas RZ/A1 IRQC Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 1927b2f36ff6..30a323a2b332 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -1,7 +1,7 @@
 /*
  * Driver for Socionext External Interrupt Unit (EXIU)
  *
- * Copyright (c) 2017 Linaro, Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (c) 2017-2019 Linaro, Ltd. <ard.biesheuvel@linaro.org>
  *
  * Based on irq-tegra.c:
  *   Copyright (C) 2011 Google, Inc.
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -134,9 +135,13 @@ static int exiu_domain_translate(struct irq_domain *domain,
 
 		*hwirq = fwspec->param[1] - info->spi_base;
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-		return 0;
+	} else {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 	}
-	return -EINVAL;
+	return 0;
 }
 
 static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
@@ -147,16 +152,21 @@ static int exiu_domain_alloc(struct irq_domain *dom, unsigned int virq,
 	struct exiu_irq_data *info = dom->host_data;
 	irq_hw_number_t hwirq;
 
-	if (fwspec->param_count != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (fwspec->param[0] != GIC_SPI)
-		return -EINVAL;	/* No PPI should point to this domain */
+	parent_fwspec = *fwspec;
+	if (is_of_node(dom->parent->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;	/* Not GIC compliant */
+		if (fwspec->param[0] != GIC_SPI)
+			return -EINVAL;	/* No PPI should point to this domain */
 
+		hwirq = fwspec->param[1] - info->spi_base;
+	} else {
+		hwirq = fwspec->param[0];
+		parent_fwspec.param[0] = hwirq + info->spi_base + 32;
+	}
 	WARN_ON(nr_irqs != 1);
-	hwirq = fwspec->param[1] - info->spi_base;
 	irq_domain_set_hwirq_and_chip(dom, virq, hwirq, &exiu_irq_chip, info);
 
-	parent_fwspec = *fwspec;
 	parent_fwspec.fwnode = dom->parent->fwnode;
 	return irq_domain_alloc_irqs_parent(dom, virq, nr_irqs, &parent_fwspec);
 }
@@ -167,35 +177,23 @@ static const struct irq_domain_ops exiu_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int __init exiu_init(struct device_node *node,
-			    struct device_node *parent)
+static struct exiu_irq_data *exiu_init(const struct fwnode_handle *fwnode,
+				       struct resource *res)
 {
-	struct irq_domain *parent_domain, *domain;
 	struct exiu_irq_data *data;
 	int err;
 
-	if (!parent) {
-		pr_err("%pOF: no parent, giving up\n", node);
-		return -ENODEV;
-	}
-
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("%pOF: unable to obtain parent domain\n", node);
-		return -ENXIO;
-	}
-
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	if (of_property_read_u32(node, "socionext,spi-base", &data->spi_base)) {
-		pr_err("%pOF: failed to parse 'spi-base' property\n", node);
+	if (fwnode_property_read_u32_array(fwnode, "socionext,spi-base",
+					   &data->spi_base, 1)) {
 		err = -ENODEV;
 		goto out_free;
 	}
 
-	data->base = of_iomap(node, 0);
+	data->base = ioremap(res->start, resource_size(res));
 	if (!data->base) {
 		err = -ENODEV;
 		goto out_free;
@@ -205,11 +203,44 @@ static int __init exiu_init(struct device_node *node,
 	writel_relaxed(0xFFFFFFFF, data->base + EIREQCLR);
 	writel_relaxed(0xFFFFFFFF, data->base + EIMASK);
 
+	return data;
+
+out_free:
+	kfree(data);
+	return ERR_PTR(err);
+}
+
+static int __init exiu_dt_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct exiu_irq_data *data;
+	struct resource res;
+
+	if (!parent) {
+		pr_err("%pOF: no parent, giving up\n", node);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: unable to obtain parent domain\n", node);
+		return -ENXIO;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("%pOF: failed to parse memory resource\n", node);
+		return -ENXIO;
+	}
+
+	data = exiu_init(of_node_to_fwnode(node), &res);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
 	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_IRQS, node,
 					  &exiu_domain_ops, data);
 	if (!domain) {
 		pr_err("%pOF: failed to allocate domain\n", node);
-		err = -ENOMEM;
 		goto out_unmap;
 	}
 
@@ -220,8 +251,57 @@ static int __init exiu_init(struct device_node *node,
 
 out_unmap:
 	iounmap(data->base);
-out_free:
 	kfree(data);
-	return err;
+	return -ENOMEM;
 }
-IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_init);
+IRQCHIP_DECLARE(exiu, "socionext,synquacer-exiu", exiu_dt_init);
+
+#ifdef CONFIG_ACPI
+static int exiu_acpi_probe(struct platform_device *pdev)
+{
+	struct irq_domain *domain;
+	struct exiu_irq_data *data;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to parse memory resource\n");
+		return -ENXIO;
+	}
+
+	data = exiu_init(dev_fwnode(&pdev->dev), res);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	domain = acpi_irq_create_hierarchy(0, NUM_IRQS, dev_fwnode(&pdev->dev),
+					   &exiu_domain_ops, data);
+	if (!domain) {
+		dev_err(&pdev->dev, "failed to create IRQ domain\n");
+		goto out_unmap;
+	}
+
+	dev_info(&pdev->dev, "%d interrupts forwarded\n", NUM_IRQS);
+
+	return 0;
+
+out_unmap:
+	iounmap(data->base);
+	kfree(data);
+	return -ENOMEM;
+}
+
+static const struct acpi_device_id exiu_acpi_ids[] = {
+	{ "SCX0008" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, exiu_acpi_ids);
+
+static struct platform_driver exiu_driver = {
+	.driver = {
+		.name = "exiu",
+		.acpi_match_table = exiu_acpi_ids,
+	},
+	.probe = exiu_acpi_probe,
+};
+builtin_platform_driver(exiu_driver);
+#endif
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index 7f0c0be322e0..d269a7722032 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -237,7 +237,6 @@ static int get_registers(struct platform_device *pdev, struct combiner *comb)
 static int __init combiner_probe(struct platform_device *pdev)
 {
 	struct combiner *combiner;
-	size_t alloc_sz;
 	int nregs;
 	int err;
 
@@ -247,8 +246,8 @@ static int __init combiner_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	alloc_sz = sizeof(*combiner) + sizeof(struct combiner_reg) * nregs;
-	combiner = devm_kzalloc(&pdev->dev, alloc_sz, GFP_KERNEL);
+	combiner = devm_kzalloc(&pdev->dev, struct_size(combiner, regs, nregs),
+				GFP_KERNEL);
 	if (!combiner)
 		return -ENOMEM;
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 98440df7fe42..70de4bc30cea 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -23,6 +23,7 @@
 
 #include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
+#include <linux/irqdomain.h>
 #include <linux/resource_ext.h>
 #include <linux/device.h>
 #include <linux/property.h>
@@ -327,6 +328,12 @@ int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 void acpi_set_irq_model(enum acpi_irq_model_id model,
 			struct fwnode_handle *fwnode);
 
+struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
+					     unsigned int size,
+					     struct fwnode_handle *fwnode,
+					     const struct irq_domain_ops *ops,
+					     void *host_data);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 9a1a479a2bf4..62a882104790 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -39,4 +39,9 @@ struct gic_kvm_info {
 
 const struct gic_kvm_info *gic_get_kvm_info(void);
 
+struct irq_domain;
+struct fwnode_handle;
+int gicv2m_init(struct fwnode_handle *parent_handle,
+		struct irq_domain *parent);
+
 #endif /* __LINUX_IRQCHIP_ARM_GIC_COMMON_H */
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 0f049b384ccd..7bd3bc6baa40 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -160,9 +160,6 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
  */
 void gic_init(void __iomem *dist , void __iomem *cpu);
 
-int gicv2m_init(struct fwnode_handle *parent_handle,
-		struct irq_domain *parent);
-
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index ff6e352e3a6c..b4f53717d143 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -2,6 +2,9 @@
 
 obj-y := irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.o devres.o
 obj-$(CONFIG_IRQ_TIMINGS) += timings.o
+ifeq ($(CONFIG_TEST_IRQ_TIMINGS),y)
+	CFLAGS_timings.o += -DDEBUG
+endif
 obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f18cd5aa33e8..4352b08ae48d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,8 +94,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				      unsigned int startvec,
+static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
 				      cpumask_var_t *node_to_cpumask,
@@ -171,8 +170,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    unsigned int startvec, unsigned int numvecs,
+static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
@@ -197,7 +195,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
+	nr_present = __irq_build_affinity_masks(curvec, numvecs,
 						firstvec, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
 
@@ -212,7 +210,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
+	nr_others = __irq_build_affinity_masks(curvec, numvecs,
 					       firstvec, node_to_cpumask,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
@@ -295,7 +293,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
+		ret = irq_build_affinity_masks(curvec, this_vecs,
 					       curvec, masks);
 		if (ret) {
 			kfree(masks);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 29d6c7d070b4..04c850fb70cb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -748,6 +748,8 @@ void handle_fasteoi_nmi(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
+	__kstat_incr_irqs_this_cpu(desc);
+
 	trace_irq_handler_entry(irq, action);
 	/*
 	 * NMIs cannot be shared, there is only one action.
@@ -962,6 +964,8 @@ void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
+	__kstat_incr_irqs_this_cpu(desc);
+
 	trace_irq_handler_entry(irq, action);
 	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 	trace_irq_handler_exit(irq, action, res);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..21f9927ff5ad 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -354,6 +354,16 @@ static inline int irq_timing_decode(u64 value, u64 *timestamp)
 	return value & U16_MAX;
 }
 
+static __always_inline void irq_timings_push(u64 ts, int irq)
+{
+	struct irq_timings *timings = this_cpu_ptr(&irq_timings);
+
+	timings->values[timings->count & IRQ_TIMINGS_MASK] =
+		irq_timing_encode(ts, irq);
+
+	timings->count++;
+}
+
 /*
  * The function record_irq_time is only called in one place in the
  * interrupts handler. We want this function always inline so the code
@@ -367,15 +377,8 @@ static __always_inline void record_irq_time(struct irq_desc *desc)
 	if (!static_branch_likely(&irq_timing_enabled))
 		return;
 
-	if (desc->istate & IRQS_TIMINGS) {
-		struct irq_timings *timings = this_cpu_ptr(&irq_timings);
-
-		timings->values[timings->count & IRQ_TIMINGS_MASK] =
-			irq_timing_encode(local_clock(),
-					  irq_desc_get_irq(desc));
-
-		timings->count++;
-	}
+	if (desc->istate & IRQS_TIMINGS)
+		irq_timings_push(local_clock(), irq_desc_get_irq(desc));
 }
 #else
 static inline void irq_remove_timings(struct irq_desc *desc) {}
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index c52b737ab8e3..9149dde5a7b0 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -946,6 +946,11 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
 }
 
+static bool irq_is_nmi(struct irq_desc *desc)
+{
+	return desc->istate & IRQS_NMI;
+}
+
 /**
  * kstat_irqs - Get the statistics for an interrupt
  * @irq:	The interrupt number
@@ -963,7 +968,8 @@ unsigned int kstat_irqs(unsigned int irq)
 	if (!desc || !desc->kstat_irqs)
 		return 0;
 	if (!irq_settings_is_per_cpu_devid(desc) &&
-	    !irq_settings_is_per_cpu(desc))
+	    !irq_settings_is_per_cpu(desc) &&
+	    !irq_is_nmi(desc))
 	    return desc->tot_count;
 
 	for_each_possible_cpu(cpu)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a453e229f99c..3078d0e48bba 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
  * @ops: domain callbacks
  * @host_data: Controller private data pointer
  *
- * Allocates and initialize and irq_domain structure.
+ * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
@@ -139,7 +139,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
-	if (WARN_ON(!domain))
+	if (!domain)
 		return NULL;
 
 	if (fwnode && is_fwnode_irqchip(fwnode)) {
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 90c735da15d0..e960d7ce7bcc 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#define pr_fmt(fmt) "irq_timings: " fmt
 
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/static_key.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/idr.h>
 #include <linux/irq.h>
@@ -261,12 +263,29 @@ void irq_timings_disable(void)
 #define EMA_ALPHA_VAL		64
 #define EMA_ALPHA_SHIFT		7
 
-#define PREDICTION_PERIOD_MIN	2
+#define PREDICTION_PERIOD_MIN	3
 #define PREDICTION_PERIOD_MAX	5
 #define PREDICTION_FACTOR	4
 #define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
 #define PREDICTION_BUFFER_SIZE	16 /* slots for EMAs, hardly more than 16 */
 
+/*
+ * Number of elements in the circular buffer: If it happens it was
+ * flushed before, then the number of elements could be smaller than
+ * IRQ_TIMINGS_SIZE, so the count is used, otherwise the array size is
+ * used as we wrapped. The index begins from zero when we did not
+ * wrap. That could be done in a nicer way with the proper circular
+ * array structure type but with the cost of extra computation in the
+ * interrupt handler hot path. We choose efficiency.
+ */
+#define for_each_irqts(i, irqts)					\
+	for (i = irqts->count < IRQ_TIMINGS_SIZE ?			\
+		     0 : irqts->count & IRQ_TIMINGS_MASK,		\
+		     irqts->count = min(IRQ_TIMINGS_SIZE,		\
+					irqts->count);			\
+	     irqts->count > 0; irqts->count--,				\
+		     i = (i + 1) & IRQ_TIMINGS_MASK)
+
 struct irqt_stat {
 	u64	last_ts;
 	u64	ema_time[PREDICTION_BUFFER_SIZE];
@@ -297,7 +316,16 @@ static u64 irq_timings_ema_new(u64 value, u64 ema_old)
 
 static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
 {
-	int i;
+	int period;
+
+	/*
+	 * Move the beginning pointer to the end minus the max period x 3.
+	 * We are at the point we can begin searching the pattern
+	 */
+	buffer = &buffer[len - (period_max * 3)];
+
+	/* Adjust the length to the maximum allowed period x 3 */
+	len = period_max * 3;
 
 	/*
 	 * The buffer contains the suite of intervals, in a ilog2
@@ -306,21 +334,45 @@ static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
 	 * period beginning at the end of the buffer. We do that for
 	 * each suffix.
 	 */
-	for (i = period_max; i >= PREDICTION_PERIOD_MIN ; i--) {
+	for (period = period_max; period >= PREDICTION_PERIOD_MIN; period--) {
 
-		int *begin = &buffer[len - (i * 3)];
-		int *ptr = begin;
+		/*
+		 * The first comparison always succeed because the
+		 * suffix is deduced from the first n-period bytes of
+		 * the buffer and we compare the initial suffix with
+		 * itself, so we can skip the first iteration.
+		 */
+		int idx = period;
+		size_t size = period;
 
 		/*
 		 * We look if the suite with period 'i' repeat
 		 * itself. If it is truncated at the end, as it
 		 * repeats we can use the period to find out the next
-		 * element.
+		 * element with the modulo.
 		 */
-		while (!memcmp(ptr, begin, i * sizeof(*ptr))) {
-			ptr += i;
-			if (ptr >= &buffer[len])
-				return begin[((i * 3) % i)];
+		while (!memcmp(buffer, &buffer[idx], size * sizeof(int))) {
+
+			/*
+			 * Move the index in a period basis
+			 */
+			idx += size;
+
+			/*
+			 * If this condition is reached, all previous
+			 * memcmp were successful, so the period is
+			 * found.
+			 */
+			if (idx == len)
+				return buffer[len % period];
+
+			/*
+			 * If the remaining elements to compare are
+			 * smaller than the period, readjust the size
+			 * of the comparison for the last iteration.
+			 */
+			if (len - idx < period)
+				size = len - idx;
 		}
 	}
 
@@ -380,11 +432,43 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	return irqs->last_ts + irqs->ema_time[index];
 }
 
+static __always_inline int irq_timings_interval_index(u64 interval)
+{
+	/*
+	 * The PREDICTION_FACTOR increase the interval size for the
+	 * array of exponential average.
+	 */
+	u64 interval_us = (interval >> 10) / PREDICTION_FACTOR;
+
+	return likely(interval_us) ? ilog2(interval_us) : 0;
+}
+
+static __always_inline void __irq_timings_store(int irq, struct irqt_stat *irqs,
+						u64 interval)
+{
+	int index;
+
+	/*
+	 * Get the index in the ema table for this interrupt.
+	 */
+	index = irq_timings_interval_index(interval);
+
+	/*
+	 * Store the index as an element of the pattern in another
+	 * circular array.
+	 */
+	irqs->circ_timings[irqs->count & IRQ_TIMINGS_MASK] = index;
+
+	irqs->ema_time[index] = irq_timings_ema_new(interval,
+						    irqs->ema_time[index]);
+
+	irqs->count++;
+}
+
 static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
 {
 	u64 old_ts = irqs->last_ts;
 	u64 interval;
-	int index;
 
 	/*
 	 * The timestamps are absolute time values, we need to compute
@@ -415,24 +499,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
 		return;
 	}
 
-	/*
-	 * Get the index in the ema table for this interrupt. The
-	 * PREDICTION_FACTOR increase the interval size for the array
-	 * of exponential average.
-	 */
-	index = likely(interval) ?
-		ilog2((interval >> 10) / PREDICTION_FACTOR) : 0;
-
-	/*
-	 * Store the index as an element of the pattern in another
-	 * circular array.
-	 */
-	irqs->circ_timings[irqs->count & IRQ_TIMINGS_MASK] = index;
-
-	irqs->ema_time[index] = irq_timings_ema_new(interval,
-						    irqs->ema_time[index]);
-
-	irqs->count++;
+	__irq_timings_store(irq, irqs, interval);
 }
 
 /**
@@ -493,11 +560,7 @@ u64 irq_timings_next_event(u64 now)
 	 * model while decrementing the counter because we consume the
 	 * data from our circular buffer.
 	 */
-
-	i = (irqts->count & IRQ_TIMINGS_MASK) - 1;
-	irqts->count = min(IRQ_TIMINGS_SIZE, irqts->count);
-
-	for (; irqts->count > 0; irqts->count--, i = (i + 1) & IRQ_TIMINGS_MASK) {
+	for_each_irqts(i, irqts) {
 		irq = irq_timing_decode(irqts->values[i], &ts);
 		s = idr_find(&irqt_stats, irq);
 		if (s)
@@ -564,3 +627,325 @@ int irq_timings_alloc(int irq)
 
 	return 0;
 }
+
+#ifdef CONFIG_TEST_IRQ_TIMINGS
+struct timings_intervals {
+	u64 *intervals;
+	size_t count;
+};
+
+/*
+ * Intervals are given in nanosecond base
+ */
+static u64 intervals0[] __initdata = {
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000,
+};
+
+static u64 intervals1[] __initdata = {
+	223947000, 1240000, 1384000, 1386000, 1386000,
+	217416000, 1236000, 1384000, 1386000, 1387000,
+	214719000, 1241000, 1386000, 1387000, 1384000,
+	213696000, 1234000, 1384000, 1386000, 1388000,
+	219904000, 1240000, 1385000, 1389000, 1385000,
+	212240000, 1240000, 1386000, 1386000, 1386000,
+	214415000, 1236000, 1384000, 1386000, 1387000,
+	214276000, 1234000,
+};
+
+static u64 intervals2[] __initdata = {
+	4000, 3000, 5000, 100000,
+	3000, 3000, 5000, 117000,
+	4000, 4000, 5000, 112000,
+	4000, 3000, 4000, 110000,
+	3000, 5000, 3000, 117000,
+	4000, 4000, 5000, 112000,
+	4000, 3000, 4000, 110000,
+	3000, 4000, 5000, 112000,
+	4000,
+};
+
+static u64 intervals3[] __initdata = {
+	1385000, 212240000, 1240000,
+	1386000, 214415000, 1236000,
+	1384000, 214276000, 1234000,
+	1386000, 214415000, 1236000,
+	1385000, 212240000, 1240000,
+	1386000, 214415000, 1236000,
+	1384000, 214276000, 1234000,
+	1386000, 214415000, 1236000,
+	1385000, 212240000, 1240000,
+};
+
+static u64 intervals4[] __initdata = {
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000,
+};
+
+static struct timings_intervals tis[] __initdata = {
+	{ intervals0, ARRAY_SIZE(intervals0) },
+	{ intervals1, ARRAY_SIZE(intervals1) },
+	{ intervals2, ARRAY_SIZE(intervals2) },
+	{ intervals3, ARRAY_SIZE(intervals3) },
+	{ intervals4, ARRAY_SIZE(intervals4) },
+};
+
+static int __init irq_timings_test_next_index(struct timings_intervals *ti)
+{
+	int _buffer[IRQ_TIMINGS_SIZE];
+	int buffer[IRQ_TIMINGS_SIZE];
+	int index, start, i, count, period_max;
+
+	count = ti->count - 1;
+
+	period_max = count > (3 * PREDICTION_PERIOD_MAX) ?
+		PREDICTION_PERIOD_MAX : count / 3;
+
+	/*
+	 * Inject all values except the last one which will be used
+	 * to compare with the next index result.
+	 */
+	pr_debug("index suite: ");
+
+	for (i = 0; i < count; i++) {
+		index = irq_timings_interval_index(ti->intervals[i]);
+		_buffer[i & IRQ_TIMINGS_MASK] = index;
+		pr_cont("%d ", index);
+	}
+
+	start = count < IRQ_TIMINGS_SIZE ? 0 :
+		count & IRQ_TIMINGS_MASK;
+
+	count = min_t(int, count, IRQ_TIMINGS_SIZE);
+
+	for (i = 0; i < count; i++) {
+		int index = (start + i) & IRQ_TIMINGS_MASK;
+		buffer[i] = _buffer[index];
+	}
+
+	index = irq_timings_next_event_index(buffer, count, period_max);
+	i = irq_timings_interval_index(ti->intervals[ti->count - 1]);
+
+	if (index != i) {
+		pr_err("Expected (%d) and computed (%d) next indexes differ\n",
+		       i, index);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init irq_timings_next_index_selftest(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(tis); i++) {
+
+		pr_info("---> Injecting intervals number #%d (count=%zd)\n",
+			i, tis[i].count);
+
+		ret = irq_timings_test_next_index(&tis[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int __init irq_timings_test_irqs(struct timings_intervals *ti)
+{
+	struct irqt_stat __percpu *s;
+	struct irqt_stat *irqs;
+	int i, index, ret, irq = 0xACE5;
+
+	ret = irq_timings_alloc(irq);
+	if (ret) {
+		pr_err("Failed to allocate irq timings\n");
+		return ret;
+	}
+
+	s = idr_find(&irqt_stats, irq);
+	if (!s) {
+		ret = -EIDRM;
+		goto out;
+	}
+
+	irqs = this_cpu_ptr(s);
+
+	for (i = 0; i < ti->count; i++) {
+
+		index = irq_timings_interval_index(ti->intervals[i]);
+		pr_debug("%d: interval=%llu ema_index=%d\n",
+			 i, ti->intervals[i], index);
+
+		__irq_timings_store(irq, irqs, ti->intervals[i]);
+		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
+			pr_err("Failed to store in the circular buffer\n");
+			goto out;
+		}
+	}
+
+	if (irqs->count != ti->count) {
+		pr_err("Count differs\n");
+		goto out;
+	}
+
+	ret = 0;
+out:
+	irq_timings_free(irq);
+
+	return ret;
+}
+
+static int __init irq_timings_irqs_selftest(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(tis); i++) {
+		pr_info("---> Injecting intervals number #%d (count=%zd)\n",
+			i, tis[i].count);
+		ret = irq_timings_test_irqs(&tis[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int __init irq_timings_test_irqts(struct irq_timings *irqts,
+					 unsigned count)
+{
+	int start = count >= IRQ_TIMINGS_SIZE ? count - IRQ_TIMINGS_SIZE : 0;
+	int i, irq, oirq = 0xBEEF;
+	u64 ots = 0xDEAD, ts;
+
+	/*
+	 * Fill the circular buffer by using the dedicated function.
+	 */
+	for (i = 0; i < count; i++) {
+		pr_debug("%d: index=%d, ts=%llX irq=%X\n",
+			 i, i & IRQ_TIMINGS_MASK, ots + i, oirq + i);
+
+		irq_timings_push(ots + i, oirq + i);
+	}
+
+	/*
+	 * Compute the first elements values after the index wrapped
+	 * up or not.
+	 */
+	ots += start;
+	oirq += start;
+
+	/*
+	 * Test the circular buffer count is correct.
+	 */
+	pr_debug("---> Checking timings array count (%d) is right\n", count);
+	if (WARN_ON(irqts->count != count))
+		return -EINVAL;
+
+	/*
+	 * Test the macro allowing to browse all the irqts.
+	 */
+	pr_debug("---> Checking the for_each_irqts() macro\n");
+	for_each_irqts(i, irqts) {
+
+		irq = irq_timing_decode(irqts->values[i], &ts);
+
+		pr_debug("index=%d, ts=%llX / %llX, irq=%X / %X\n",
+			 i, ts, ots, irq, oirq);
+
+		if (WARN_ON(ts != ots || irq != oirq))
+			return -EINVAL;
+
+		ots++; oirq++;
+	}
+
+	/*
+	 * The circular buffer should have be flushed when browsed
+	 * with for_each_irqts
+	 */
+	pr_debug("---> Checking timings array is empty after browsing it\n");
+	if (WARN_ON(irqts->count))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init irq_timings_irqts_selftest(void)
+{
+	struct irq_timings *irqts = this_cpu_ptr(&irq_timings);
+	int i, ret;
+
+	/*
+	 * Test the circular buffer with different number of
+	 * elements. The purpose is to test at the limits (empty, half
+	 * full, full, wrapped with the cursor at the boundaries,
+	 * wrapped several times, etc ...
+	 */
+	int count[] = { 0,
+			IRQ_TIMINGS_SIZE >> 1,
+			IRQ_TIMINGS_SIZE,
+			IRQ_TIMINGS_SIZE + (IRQ_TIMINGS_SIZE >> 1),
+			2 * IRQ_TIMINGS_SIZE,
+			(2 * IRQ_TIMINGS_SIZE) + 3,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(count); i++) {
+
+		pr_info("---> Checking the timings with %d/%d values\n",
+			count[i], IRQ_TIMINGS_SIZE);
+
+		ret = irq_timings_test_irqts(irqts, count[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int __init irq_timings_selftest(void)
+{
+	int ret;
+
+	pr_info("------------------- selftest start -----------------\n");
+
+	/*
+	 * At this point, we don't except any subsystem to use the irq
+	 * timings but us, so it should not be enabled.
+	 */
+	if (static_branch_unlikely(&irq_timing_enabled)) {
+		pr_warn("irq timings already initialized, skipping selftest\n");
+		return 0;
+	}
+
+	ret = irq_timings_irqts_selftest();
+	if (ret)
+		goto out;
+
+	ret = irq_timings_irqs_selftest();
+	if (ret)
+		goto out;
+
+	ret = irq_timings_next_index_selftest();
+out:
+	pr_info("---------- selftest end with %s -----------\n",
+		ret ? "failure" : "success");
+
+	return ret;
+}
+early_initcall(irq_timings_selftest);
+#endif
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2c3382378d94..eaf3bdf7c749 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -650,7 +650,7 @@ static int takeover_tasklets(unsigned int cpu)
 	/* Find end, append list for that CPU. */
 	if (&per_cpu(tasklet_vec, cpu).head != per_cpu(tasklet_vec, cpu).tail) {
 		*__this_cpu_read(tasklet_vec.tail) = per_cpu(tasklet_vec, cpu).head;
-		this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
+		__this_cpu_write(tasklet_vec.tail, per_cpu(tasklet_vec, cpu).tail);
 		per_cpu(tasklet_vec, cpu).head = NULL;
 		per_cpu(tasklet_vec, cpu).tail = &per_cpu(tasklet_vec, cpu).head;
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae379896..f0788eea64bd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1858,6 +1858,14 @@ config TEST_PARMAN
 
 	  If unsure, say N.
 
+config TEST_IRQ_TIMINGS
+	bool "IRQ timings selftest"
+	depends on IRQ_TIMINGS
+	help
+	  Enable this option to test the irq timings code on boot.
+
+	  If unsure, say N.
+
 config TEST_LKM
 	tristate "Test module loading with 'hello world' module"
 	depends on m

